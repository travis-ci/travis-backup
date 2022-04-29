# frozen_string_literal: true

require 'backup/save_file'
require 'backup/remove_specified/shared'

class Backup
  class RemoveSpecified
    module RemoveHeavyData
      include SaveIdHashToFile
      include SaveNullifiedRelsToFile
      include Shared

      def remove_heavy_data_for_repos_owned_by(owner_id, owner_type)
        Repository.where('owner_id = ? and owner_type = ?', owner_id, owner_type).order(:id).each do |repository|
          remove_heavy_data_for_repo(repository)
        end
      end

      def remove_heavy_data_for_repo(repository)
        # remove_repo_builds(repository)
        remove_repo_requests(repository)
      end

      # def remove_repo_builds(repository) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      #   threshold = @config.threshold.to_i.months.ago.to_datetime
      #   builds_to_remove = repository.builds.where('created_at < ?', threshold)

      #   builds_dependencies = builds_to_remove.map do |build|
      #     result = build.ids_of_all_dependencies(dependencies_to_filter, :without_parents)
      #     result.add(:build, build.id)
      #     result
      #   end.compact

      #   ids_to_remove = IdHash.join(*builds_dependencies)
      #   @subfolder = "repository_#{repository.id}_old_builds_#{current_time_for_subfolder}"

      #   unless @config.dry_run
      #     nullified_rels = builds_to_remove&.map(&:nullify_default_dependencies)&.flatten
      #     save_nullified_rels_to_file(build: nullified_rels) if @config.if_backup
      #   end

      #   process_ids_to_remove(ids_to_remove)
      # end

      def remove_repo_requests(repository)
        threshold = @config.threshold.to_i.months.ago.to_datetime
        requests_to_remove = repository.requests.where('created_at < ?', threshold)

        requests_dependencies = requests_to_remove.map do |request|
          hash_with_filtered = request.ids_of_all_dependencies(dependencies_to_filter, :without_parents)
          hash_with_filtered.add(:request, request.id)
        end

        @subfolder = "repository_#{repository.id}_old_requests_#{current_time_for_subfolder}"

        unless @config.dry_run
          nullified_rels = requests_to_remove.map do |request|
            nullify_filtered_dependencies(request)
          end.flatten
          save_nullified_rels_to_file(build: nullified_rels) if @config.if_backup
        end

        ids_to_remove = IdHash.join(*(requests_dependencies))
        orphaned_ids = orphaned_configs_to_remove(repository, ids_to_remove)
        ids_to_remove.join(orphaned_ids)
        process_ids_to_remove(ids_to_remove)
      end

      private

      def find_config_ids_orphaned_now(model1:, model2:, repository:, foreign_key:, ids_to_remove:)
        ids_to_exclude = ids_to_remove[model2.table_name.singularize.to_sym].join(', ')

        orphaned_earlier = model1.find_by_sql(%{
          select a.id
          from #{model1.table_name} as a
          left join #{model2.table_name} as b on
          a.id = b.#{foreign_key}
          where a.repository_id = #{repository.id}
          group by a.id
          having count(b.id) = 0;
        }).map { |x| x.id }


        all_orphaned = model1.find_by_sql(%{
          select a.id
          from #{model1.table_name} as a
          left join #{model2.table_name} as b on
          a.id = b.#{foreign_key} and b.id not in (#{ids_to_exclude})
          where a.repository_id = #{repository.id}
          group by a.id
          having count(b.id) = 0;
        }).map { |x| x.id }

        all_orphaned - orphaned_earlier
      end

      def orphaned_configs_to_remove(repository, ids_to_remove)
        if ids_to_remove[:request]
          request_config_ids = find_config_ids_orphaned_now(
            model1: RequestConfig,
            model2: Request,
            repository: repository,
            foreign_key: 'config_id',
            ids_to_remove: ids_to_remove
          )
          request_yaml_config_ids = find_config_ids_orphaned_now(
            model1: RequestYamlConfig,
            model2: Request,
            repository: repository,
            foreign_key: 'yaml_config_id',
            ids_to_remove: ids_to_remove
          )
        end

        if ids_to_remove[:request_raw_configuration]
          request_raw_config_ids = find_config_ids_orphaned_now(
            model1: RequestRawConfig,
            model2: RequestRawConfiguration,
            repository: repository,
            foreign_key: 'request_raw_config_id',
            ids_to_remove: ids_to_remove
          )
        end

        if ids_to_remove[:build]
          build_config_ids = find_config_ids_orphaned_now(
            model1: BuildConfig,
            model2: Build,
            repository: repository,
            foreign_key: 'config_id',
            ids_to_remove: ids_to_remove
          )
        end

        if ids_to_remove[:job]
          job_config_ids = find_config_ids_orphaned_now(
            model1: JobConfig,
            model2: Job,
            repository: repository,
            foreign_key: 'config_id',
            ids_to_remove: ids_to_remove
          )
        end

        orphaned_ids = IdHash.new
        orphaned_ids.add(:request_config, *request_config_ids)
        orphaned_ids.add(:request_yaml_config, *request_yaml_config_ids)
        orphaned_ids.add(:request_raw_config, *request_raw_config_ids)
        orphaned_ids.add(:build_config, *build_config_ids)
        orphaned_ids.add(:job_config, *job_config_ids)
        orphaned_ids
      end

      def process_ids_to_remove(ids_to_remove)
        if @config.dry_run
          @dry_run_reporter.add_to_report(ids_to_remove.with_table_symbols)
        else
          save_id_hash_to_file(ids_to_remove) if @config.if_backup
          ids_to_remove.remove_entries_from_db
        end
      end

      def save_and_destroy_requests_batch(requests_batch, repository)
        requests_export = requests_batch.map(&:attributes)
        file_name = "repository_#{repository.id}_requests_#{requests_batch.first.id}-#{requests_batch.last.id}.json"
        pretty_json = JSON.pretty_generate(requests_export)
        if save_file(file_name, pretty_json)
          destroy_requests_batch(requests_batch)
        end
        requests_export
      end

      def destroy_requests_batch(requests_batch)
        return destroy_requests_batch_dry(requests_batch) if @config.dry_run

        requests_batch.each(&:destroy)
      end

      def destroy_requests_batch_dry(requests_batch)
        @dry_run_reporter.add_to_report(:requests, *requests_batch.map(&:id))
      end
    end
  end
end
