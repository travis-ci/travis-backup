# frozen_string_literal: true

require 'id_hash'

class Backup
  class LoadFromFiles
    class JsonContent < String
      def hash
        @hash ||= JSON.parse(self).symbolize_keys
      end
    end

    class DataFile
      attr_accessor :content

      def initialize(json_content)
        @content = json_content
      end

      def table_name
        @content.match(/"table_name":\s?"(\w+)"/)[1]
      end

      def table_name_sym
        table_name.to_sym
      end

      def full_hash
        @content.hash
      end
    end

    class EntryFile < DataFile
      def ids
        @content.scan(/"id":\s?(\d+)/).flatten.map(&:to_i)
      end

      def lowest_id
        ids.min
      end

      def entries
        full_hash[:data]
      end
    end

    class RelationshipFile < DataFile
      def relationships
        @relationships ||= full_hash[:nullified_relationships].map do |rel|
          rel.symbolize_keys
        end
      end
    end

    def initialize(config, dry_run_reporter=nil)
      @config = config
      @dry_run_reporter = dry_run_reporter
      @touched_models = []
    end

    def run
      set_id_offsets
      load_data_with_offsets
      cancel_offset_for_foreign_data
      set_id_sequences
      load_nullified_relationships
    end

    private

    def load_nullified_relationships
      relationship_files.each do |file|
        file.relationships.each do |rel|
          offset = @id_offsets[file.table_name.to_sym]

          ActiveRecord::Base.connection.execute(%{
            update #{rel[:related_table]}
            set #{rel[:foreign_key]} = #{rel[:parent_id].to_i + offset}
            where id = #{rel[:related_id].to_i};
          })
        end
      end
    end

    def set_id_sequences
      @touched_models.each do |model|
        value = model.last.id + 1
        seq = model.table_name + '_id_seq'
        set_sequence(seq, value)
      end

      set_shared_builds_tasks_seq
    end

    def set_shared_builds_tasks_seq
      value = [Build.last&.id || -1, Job.last&.id || -1].max + 1

      if value > 0
        set_sequence("shared_builds_tasks_seq", value)
      end
    end

    def set_sequence(seq, value)
      ActiveRecord::Base.connection.execute("alter sequence #{seq} restart with #{value};")
    end

    def cancel_offset_for_foreign_data
      @loaded_entries.each do |entry|
        entry.class.reflect_on_all_associations.select { |a| a.macro == :belongs_to }.each do |association|
          foreign_key = association.foreign_key.to_sym
          if entry.send(association.name).nil? && entry.send(foreign_key).present?
            entry_hash = entry.attributes.symbolize_keys
            table_name = get_table_name(entry_hash, association)
            offset = @id_offsets[table_name.to_sym]
            next if offset.nil?

            proper_id = entry.send(foreign_key) - offset
            entry.update(foreign_key => proper_id)
          end
        end
      end
    end

    def load_data_with_offsets
      @repository_files = []

      @loaded_entries = entry_files.map do |data_file|
        model = Model.get_model_by_table_name(data_file.table_name)

        if model == Repository
          @repository_files << data_file
          next
        end

        load_file(model, data_file)
      end.flatten.compact

      repository_entries = @repository_files.map do |data_file|
        load_file(Repository, data_file)
      end.flatten.compact

      @loaded_entries.concat(repository_entries)
    end

    def load_file(model, data_file)
      @touched_models << model

      data_file.entries&.map do |entry_hash|
        load_entry(model, entry_hash)
      end
    end

    def load_entry(model, entry_hash)
      entry_hash.symbolize_keys!
      entry_hash[:id] += @id_offsets[model.table_name.to_sym]
      add_offset_to_foreign_keys!(model, entry_hash)
      model.create(entry_hash)
    end

    def add_offset_to_foreign_keys!(model, entry_hash)
      model.reflect_on_all_associations.select { |a| a.macro == :belongs_to }.each do |association|
        foreign_key_sym = association.foreign_key.to_sym
        next unless entry_hash[foreign_key_sym]

        table_name = get_table_name(entry_hash, association)
        entry_hash[foreign_key_sym] += @id_offsets[table_name.to_sym] || 0
      end
    end

    def get_table_name(entry_hash, association)
      if association.polymorphic?
        type_symbol = association.foreign_key.gsub(/_id$/, '_type').to_sym
        class_name = entry_hash[type_symbol]
      else
        class_name = association.class_name
      end

      Model.get_model(class_name).table_name
    end

    def file_contents
      @file_contents ||= Dir["#{@config.files_location}/**/*.json"].map do |file_path|
        JsonContent.new(File.read(file_path))
      end
    end

    def entry_files
      @entry_files ||= file_contents.map do |content|
        next unless content.hash[:data]

        EntryFile.new(content)
      end.compact
    end

    def relationship_files
      @relationship_files ||= file_contents.map do |content|
        next if content.hash[:data]

        RelationshipFile.new(content)
      end.compact
    end

    def find_lowest_ids_from_files
      @lowest_ids_from_files = HashOfArrays.new

      entry_files.each do |data_file|
        table_name = data_file.table_name_sym
        min_id = data_file.lowest_id
        @lowest_ids_from_files.add(table_name, min_id) if min_id
      end

      @lowest_ids_from_files = @lowest_ids_from_files.map { |k, arr| [k, arr.min] }.to_h
    end

    def find_highest_ids_from_db
      @highest_ids_from_db = {}

      Model.subclasses.each do |model|
        table_name = model.table_name.to_sym
        @highest_ids_from_db[table_name] = model.order(:id).last&.id || 0
      end
    end

    def set_id_offsets
      find_lowest_ids_from_files
      find_highest_ids_from_db

      @id_offsets = @lowest_ids_from_files.map do |key, file_min|
        db_max = @highest_ids_from_db[key]
        offset = db_max - file_min + @config.id_gap
        [key, offset]
      end.to_h

      make_offset_common_for_builds_and_jobs
    end

    def make_offset_common_for_builds_and_jobs
      if @id_offsets[:builds] && @id_offsets[:jobs]
        offset = [@id_offsets[:builds], @id_offsets[:jobs]].max
        @id_offsets[:builds] = offset
        @id_offsets[:jobs] = offset
      end
    end
  end
end