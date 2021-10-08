# frozen_string_literal: true

require 'backup/save_file'

module RemoveWithAllDependencies
  include SaveFile

  def remove_user_with_dependencies(user_id)
    user = User.find(user_id)
    ids_of_all_dependencies = user.ids_of_all_dependencies(dependencies_to_filter)
    remove_ids_from_hash(ids_of_all_dependencies[:main])
    user.delete
  end

  def remove_org_with_dependencies(org_id)
    
  end

  def remove_repo_with_dependencies(repo_id)
    
  end

  private

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

  def remove_ids_from_hash(ids_hash)
    ids_hash.each do |name, ids|
      next if name == :build

      model = Utils.get_model(name)
      model.delete(ids)
    end
    Build.delete(ids_hash[:build])
    # order important because of foreign key constraint between builds and repos
  end
end
