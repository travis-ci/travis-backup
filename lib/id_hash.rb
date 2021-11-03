require 'model'

class HashOfArrays < Hash
  def initialize(hash = {})
    hash.each do |key, array|
      self[key] = hash[key].clone
    end
  end

  def clone
    self.class.new(self)
  end

  def subtract(hash)
    result = self.clone
    hash.each do |key, array|
      next if result[key].nil?

      array.each do |el|
        result[key].delete(el)
      end

      result.delete(key) if result[key].empty?
    end
    result
  end

  def add(key, *values)
    self[key] = [] if self[key].nil?
    self[key].concat(values)
  end

  def self.join(*hashes)
    result = self.new
    result.join(*hashes)
  end

  def join(*hashes)
    hashes.each do |hash|
      hash.each do |key, array|
        self.add(key, *array)
      end
    end
    self
  end

  def sort_arrays!
    self.each do |key, array|
      array.sort!
    end
  end
end

class IdHash < HashOfArrays
  def add(key, *values)
    super(key, *values)
    self[key].uniq!
  end

  def remove_entries_from_db(as_first: [], as_last: [])
    exceptionals = as_first + as_last
    remove_from_exceptional(as_first)

    self.each do |name, ids|
      next if exceptionals.include?(name)
      remove_entries_from_array(name, ids)
    end

    remove_from_exceptional(as_last)
  end

  def with_table_symbols
    result = HashOfArrays.new

    self.each do |name, ids|
      symbol = Model.get_model(name).table_name.to_sym
      result[symbol] = ids
    end

    result
  end

  private

  def remove_from_exceptional(array)
    array.each do |name|
      ids = self[name]
      remove_entries_from_array(name, ids)
    end
  end

  def remove_entries_from_array(model_name, ids)
    model = Model.get_model(model_name)
    model.delete(ids) if model.present?
  end
end
