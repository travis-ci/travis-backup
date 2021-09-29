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
end