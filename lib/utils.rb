class Utils
  def self.uniquely_join_hashes_of_arrays(*hashes)
    result = {}
    hashes.each do |hash|
      hash.each do |key, array|
        if result[key].nil?
          result[key] = array
        else
          result[key].concat(array).uniq!
        end
      end
    end
    result
  end

  def self.clone_hash_of_arrays(hash)
    result = {}
    hash.each do |key, array|
      result[key] = hash[key].clone
    end
    result
  end

  def self.difference_of_two_hashes_of_arrays(hash1, hash2)
    result = self.clone_hash_of_arrays(hash1)
    hash2.each do |key, array|
      next if hash1[key].nil?

      array.each do |el|
        result[key].delete(el)
      end

      result.delete(key) if result[key].empty?
    end
    result
  end

  def self.get_model(name)
    Model.subclasses.find{ |m| m.name == name.to_s.camelcase }
  end

  def self.get_sum_of_rows_of_all_models
    Model.subclasses.map do |subclass|
      subclass.all.size
    end.reduce(:+)
  end
end