# frozen_string_literal: true

require 'backup/save_id_hash_to_file'
require 'backup/save_nullified_rels_to_file'
require 'models/user'
require 'models/repository'
require 'backup/remove_specified/shared'

class Backup
  class RemoveSpecified
    module RemoveWithAllDependencies
      include SaveIdHashToFile
      include SaveNullifiedRelsToFile
      include Shared

      def remove_user_with_dependencies(user_id)
        remove_entry_with_dependencies(:user, user_id)
      end

      def remove_org_with_dependencies(org_id)
        remove_entry_with_dependencies(:organization, org_id)
      end

      def remove_repo_with_dependencies(repo_id)
        remove_entry_with_dependencies(:repository, repo_id)
      end

      private

      def remove_entry_with_dependencies(model_name, id)
        @subfolder = "#{model_name}_#{id}_#{time_for_subfolder}"
        entry = Model.get_model(model_name).find(id)
        hash_with_filtered = entry.ids_of_all_dependencies_with_filtered(dependencies_to_filter, :without_parents)
        ids_to_remove = hash_with_filtered[:main]
        ids_to_remove.add(model_name, id)

        return @dry_run_reporter.add_to_report(ids_to_remove) if @config.dry_run

        nullified_rels = { build: nullify_filtered_dependencies(entry) || [] }

        if @config.if_backup
          save_nullified_rels_to_file(nullified_rels)
          save_id_hash_to_file(ids_to_remove)
        end

        ids_to_remove.remove_entries_from_db(as_last: [:build])
          # order important because of foreign key constraint between builds and repos
      end
    end
  end
end
