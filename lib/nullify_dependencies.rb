# frozen_string_literal: true

module NullifyDependencies
  def nullify_dependencies(dependencies_symbols_to_nullify)
    dependencies_symbols_to_nullify.map do |symbol|
      dependencies = self.send(symbol) # e.g. build.tags_for_that_this_build_is_last

      dependencies.map do |entry|
        foreign_key = self.class.reflect_on_association(symbol).foreign_key.to_sym
        entry.update(foreign_key => nil) # e.g. tag.update(last_build_id: nil)
        {
          related_table: entry.class.table_name,
          foreign_key: foreign_key,
          parent_id: self.id,
          related_id: entry.id
        }
      end
    end.flatten
  end
  
  def nullify_all_dependencies
    nullify_dependencies(symbols_of_all_direct_dependencies)
  end

  def nullify_default_dependencies
    nullify_dependencies(default_dependencies_symbols_to_nullify)
  end

  def default_dependencies_symbols_to_nullify
    self.class.default_dependencies_symbols_to_nullify
  end

  def self.default_dependencies_symbols_to_nullify
    raise "self.default_dependencies_symbols_to_nullify not implemented in the #{self.class} class"
  end

  def default_dependencies_to_nullify
    default_dependencies_symbols_to_nullify.map do |symbol|
      self.send(symbol).to_a
    end.flatten(1)
  end
end