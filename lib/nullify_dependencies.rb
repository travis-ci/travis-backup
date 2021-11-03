# frozen_string_literal: true

module NullifyDependencies
  def nullify_dependencies(dependencies_to_nullify)
    dependencies_to_nullify.each do |symbol|
      dependencies = self.send(symbol) # e.g. build.tags_for_that_this_build_is_last

      dependencies.each do |entry|
        foreign_key = self.class.reflect_on_association(symbol).foreign_key.to_sym
        entry.update(foreign_key => nil) # e.g. tag.update(last_build_id: nil)
      end
    end
  end

  def nullify_default_dependencies
    nullify_dependencies(default_dependencies_to_nullify)
  end

  def default_dependencies_to_nullify
    raise "default_dependencies_to_nullify not implemented in the #{self.class} class"
  end
end