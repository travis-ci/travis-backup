require 'backup/save_file'

module SaveIdHashToFile
  include SaveFile

  def save_id_hash_to_file(id_hash)
    id_hash.each do |name, ids|
      ids.sort.each_slice(@config.limit.to_i) do |ids_batch|
        save_ids_batch_to_file(name, ids_batch)
      end
    end
  end

  def save_ids_batch_to_file(name, ids_batch)
    model = Model.get_model(name)
    export = {}
    export[:table_name] = model.table_name
    export[:data] = ids_batch.map do |id|
      get_exported_object(model, id)
    end

    content = JSON.pretty_generate(export)
    file_name = "#{name}_#{ids_batch.first}-#{ids_batch.last}.json"
    file_path = @subfolder.present? ? "#{@subfolder}/#{file_name}" : file_name
    save_file(file_path, content)
  end

  def get_exported_object(model, id)
    object = model.find(id)
    object.attributes
  end
end