require 'backup/save_file'

module SaveNullifiedRelsToFile
  include SaveFile

  def save_nullified_rels_to_file(rels_hash)
    @file_index = 1

    rels_hash.each do |name, rels|
      rels.compact.each_slice(@config.limit.to_i) do |rels_batch|
        save_rels_batch_to_file(name, rels_batch)
      end
    end
  end

  def save_rels_batch_to_file(name, rels_batch)
    model = Model.get_model(name)

    export = {}
    export[:table_name] = model.table_name
    export[:nullified_relationships] = rels_batch

    content = JSON.pretty_generate(export)
    file_name = "nullified_relationships/build_#{@file_index}.json"
    @file_index += 1
    file_path = @subfolder.present? ? "#{@subfolder}/#{file_name}" : file_name
    save_file(file_path, content)
  end
end