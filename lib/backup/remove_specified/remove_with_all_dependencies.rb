# frozen_string_literal: true

require 'backup/save_id_hash_to_file'
require 'models/user'
require 'models/repository'

module RemoveWithAllDependencies
  include SaveIdHashToFile

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
    ids_to_remove = entry.ids_of_all_dependencies(dependencies_to_filter)[:main]
    ids_to_remove[model_name] = [id]

    if @config.dry_run
      @dry_run_reporter.add_to_report(ids_to_remove)
    else
      save_id_hash_to_file(ids_to_remove) if @config.if_backup
      ids_to_remove.remove_entries_from_db(as_last: [:build])
      # order important because of foreign key constraint between builds and repos
    end
  end

  def time_for_subfolder
    Time.now.to_s.parameterize.underscore
  end

  def dependencies_to_filter
    {
      build: [
        :repos_for_that_this_build_is_current,
        :repos_for_that_this_build_is_last,
        :tags_for_that_this_build_is_last,
        :branches_for_that_this_build_is_last
      ]
    }
  end
end
