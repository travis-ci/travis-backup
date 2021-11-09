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
    byebug
    @subfolder = "#{model_name}_#{id}_#{time_for_subfolder}"
    entry = Model.get_model(model_name).find(id)
    hash_with_filtered = entry.ids_of_all_dependencies_with_filtered(dependencies_to_filter)
    ids_to_remove = hash_with_filtered[:main]
    ids_to_remove.add(model_name, id)
    ids_to_remove.join(hash_with_filtered[:filtered_out])
    filtered_builds = hash_with_filtered[:filtered_out]&.[](:build)&.map { |id| Build.find(id) }
    # ids_to_remove.join(*filtered_builds.map(&:ids_of_all_dependencies)) <- problem here

    if @config.dry_run
      @dry_run_reporter.add_to_report(ids_to_remove)
    else
      filtered_builds&.each(&:nullify_default_dependencies)
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
      build: Build.default_dependencies_to_nullify
    }
  end
end
