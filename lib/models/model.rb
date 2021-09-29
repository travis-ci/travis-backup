# frozen_string_literal: true

require 'active_record'
require './utils'

# Model class
class Model < ActiveRecord::Base
  self.abstract_class = true

  def attributes_without_id
    self.attributes.reject{|k, v| k == "id"}
  end

  def ids_of_all_dependencies
    result = {}
    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to
      symbol = association.klass.name.underscore.to_sym

      self.send(association.name).map(&:id).map do |id|
        if result[symbol].nil?
          result[symbol] = [id]
        else
          result[symbol] << id
        end
      end

      grandchildren_hashes = self.send(association.name).map(&:ids_of_all_dependencies)
      result = Utils.uniquely_join_hashes_of_arrays(result, *grandchildren_hashes)
    end
    result
  end
end

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'abuse', 'abuses'
end
