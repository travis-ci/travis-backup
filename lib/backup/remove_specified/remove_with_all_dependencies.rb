# frozen_string_literal: true

require 'backup/save_file'

module RemoveWithAllDependencies
  include SaveFile

  def remove_user_with_dependencies(user_id)
    date = Time.now.to_s.parameterize.underscore
    @subfolder = "user_#{user_id}_#{date}"
    user = User.find(user_id)
    ids_to_remove = user.ids_of_all_dependencies(dependencies_to_filter)[:main]
    ids_to_remove[:user] = [user_id]
    save_ids_hash_to_file(ids_to_remove)
    remove_ids_from_hash(ids_to_remove)
  end

  def remove_org_with_dependencies(org_id)
    
  end

  def remove_repo_with_dependencies(repo_id)
    
  end

  private

  def save_ids_hash_to_file(ids_hash)
    ids_hash.each do |name, ids|
      ids.sort.each_slice(@config.limit.to_i) do |ids_batch|
        save_ids_batch_to_file(name, ids_batch)
      end
    end
  end

  def save_ids_batch_to_file(name, ids_batch)
    model = Utils.get_model(name)

    export = {}
    export[:table_name] = model.table_name
    export[:data] = ids_batch.map do |id|
      get_exported_object(model, id)
    end

    content = JSON.pretty_generate(export)
    file_name = "#{@subfolder}/#{name}_#{ids_batch.first}-#{ids_batch.last}.json"
    save_file(file_name, content)
  end

  def get_exported_object(model, id)
    object = model.find(id)
    result = object.attributes
    result[:_dependencies_] = object.ids_of_all_direct_dependencies
    result
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