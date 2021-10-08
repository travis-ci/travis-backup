# frozen_string_literal: true

module RemoveWithAllDependencies
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

  def remove_user_with_dependencies(user_id)
    user = User.find(user_id)
    ids_of_all_dependencies = user.ids_of_all_dependencies(dependencies_to_filter)
    remove_ids_from_hash(ids_of_all_dependencies[:main])
    user.delete
  end

  def remove_ids_present_in_main_from_filtered_out!(ids_hash)
    ids_hash[:main].each do |name, ids|
      ids.each do |id|
        ids_hash[:filtered_out][name]&.delete(id)
      end
    end
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

  def filter_builds_with_filtered_dependencies!(ids_of_all_dependencies)
    builds = ids_of_all_dependencies[:main][:build]
    return unless builds

    ids_to_filter = get_builds_to_filter(ids_of_all_dependencies)
    ids_to_filter.each do |id|
      builds.delete(id)
    end

    filtered = ids_of_all_dependencies[:filtered_out]
    filtered[:build] = [] if filtered[:build].nil?
    filtered[:build].concat(ids_to_filter)
    filtered[:build].uniq!
  end

  def get_builds_to_filter(ids_hash)
    builds_to_filter = []

    ids_hash[:filtered_out].each do |name, ids|
      model = Utils.get_model(name)
      model.where(id: ids).each do |instance|
        [:last_build_id, :current_build_id].each do |method|
          build_id = instance.try(method)
          builds_to_filter << build_id
        end
      end
    end

    builds_to_filter.compact!
    builds_to_filter.uniq!
  end

  def remove_org_with_dependencies(org_id)
    
  end

  def remove_repo_with_dependencies(repo_id)
    
  end
end
