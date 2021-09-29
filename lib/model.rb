# frozen_string_literal: true

require 'active_record'
require './utils'

# Model class
class Model < ActiveRecord::Base
  self.abstract_class = true

  def attributes_without_id
    self.attributes.reject{|k, v| k == "id"}
  end

  def ids_of_all_dependencies(to_filter={})
    to_filter.default = []
    main = {}
    filtered_out = {}
    self_symbol = self.class.name.underscore.to_sym

    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to
      symbol = association.klass.name.underscore.to_sym
      self.send(association.name).map(&:id).map do |id|
        # puts '.'
        # puts self_symbol
        # puts association.name
        if to_filter[self_symbol].any? { |a| a == association.name }
          hash_to_use = filtered_out
        else
          hash_to_use = main
        end

        if hash_to_use[symbol].nil?
          hash_to_use[symbol] = [id]
        else
          hash_to_use[symbol] << id
        end
      end

      grandchildren_hashes = self.send(association.name).map do |model|
        next if to_filter[self_symbol].any? { |a| a == association.name }
        model.ids_of_all_dependencies(to_filter)
      end.compact

      grandchildren_main = grandchildren_hashes.map { |hash| hash[:main] }
      grandchildren_filtered_out = grandchildren_hashes.map { |hash| hash[:filtered_out] }

      main = Utils.uniquely_join_hashes_of_arrays(main, *grandchildren_main)
      filtered_out = Utils.uniquely_join_hashes_of_arrays(filtered_out, *grandchildren_filtered_out)
    end

    { main: main, filtered_out: filtered_out }
  end
end

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'abuse', 'abuses'
end
