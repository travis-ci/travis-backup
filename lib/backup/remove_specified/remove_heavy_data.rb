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

      def orphaned_configs_to_remove(repository, ids_to_remove)
        if ids_to_remove[:request]
          request_config_ids = RequestConfig.find_by_sql(%{
            select a.id
            from request_configs as a
            left join requests as b on
            a.id = b.config_id and b.id not in (#{ids_to_remove[:request].join(', ')})
            where a.repository_id = #{repository.id}
            group by a.id
            having count(b.id) = 0;           
          }).map { |x| x.id }

          request_yaml_config_ids = RequestYamlConfig.find_by_sql(%{
            select a.id
            from request_yaml_configs as a
            left join requests as b on
            a.id = b.yaml_config_id and b.id not in (#{ids_to_remove[:request].join(', ')})
            where a.repository_id = #{repository.id}
            group by a.id
            having count(b.id) = 0;           
          }).map { |x| x.id }
        end

        if ids_to_remove[:request_raw_configuration]
          request_raw_config_ids = RequestRawConfig.find_by_sql(%{
            select a.id
            from request_raw_configs as a
            left join request_raw_configurations as b on
            a.id = b.request_raw_config_id and b.id not in (#{ids_to_remove[:request_raw_configuration].join(', ')})
            where a.repository_id = #{repository.id}
            group by a.id
            having count(b.id) = 0;           
          }).map { |x| x.id }
        end

        if ids_to_remove[:build]
          build_config_ids = BuildConfig.find_by_sql(%{
            select a.id
            from build_configs as a
            left join builds as b on
            a.id = b.config_id and b.id not in (#{ids_to_remove[:build].join(', ')})
            where a.repository_id = #{repository.id}
            group by a.id
            having count(b.id) = 0;
          }).map { |x| x.id }
        end

        if ids_to_remove[:job]
          job_config_ids = JobConfig.find_by_sql(%{
            select a.id
            from job_configs as a
            left join jobs as b on
            a.id = b.config_id and b.id not in (#{ids_to_remove[:job].join(', ')})
            where a.repository_id = #{repository.id}
            group by a.id
            having count(b.id) = 0;
          }).map { |x| x.id }
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
