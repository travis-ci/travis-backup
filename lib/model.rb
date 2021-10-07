# frozen_string_literal: true

require 'active_record'
require './utils'

module IdsOfAllDependenciesJson
  def ids_of_all_dependencies_json
    result = {}
    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to
      symbol = association.klass.name.underscore.to_sym
      self.send(association.name).map do |associated_object|
        result[symbol] = [] if result[symbol].nil?
        result[symbol] << associated_object.ids_of_all_dependencies_json
      end
    end
    result[:id] = "#{self.class.name.underscore}-#{id}"
    result = result[:id] if result.size == 1
    result
  end
end

module IdsOfAllDependencies
  def ids_of_all_dependencies(to_filter={})
    result = { main: {}, filtered_out: {} }

    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to
      symbol = association.klass.name.underscore.to_sym
      context = { to_filter: to_filter, association: association }

      self.send(association.name).map do |associated_object|
        hash_to_use = get_hash_to_use(result, **context, object: associated_object)
        hash_to_use[symbol] = [] if hash_to_use[symbol].nil?
        hash_to_use[symbol] << associated_object.id
      end
      result = get_result_with_grandchildren_hashes(result, context)
    end

    result
  end

  private

  def get_result_with_grandchildren_hashes(result, context)
    hashes = get_grandchildren_hashes(context)
    main = hashes.map { |hash| hash[:main] }
    filtered_out = hashes.map { |hash| hash[:filtered_out] }

    result[:main] = Utils.uniquely_join_hashes_of_arrays(result[:main], *main)
    result[:filtered_out] = Utils.uniquely_join_hashes_of_arrays(result[:filtered_out], *filtered_out)
    result
  end

  def get_grandchildren_hashes(context)
    association = context[:association]
    to_filter = context[:to_filter]

    self.send(association.name).map do |associated_object|
      next if should_be_filtered?(**context, object: associated_object)
      associated_object.ids_of_all_dependencies(to_filter)
    end.compact
  end

  def get_hash_to_use(result, context)
    symbol = should_be_filtered?(**context) ? :filtered_out : :main
    result[symbol]
  end

  def should_be_filtered?(to_filter:, association:, object:)
    symbol = association.klass.name.underscore.to_sym

    association.klass.reflect_on_all_associations.each do |association2|
      next if association2.macro == :belongs_to

      context = { to_filter: to_filter, symbol: symbol, association: association2 }
      return true if object.send(association2.name).any? && is_this_association_filtered(context)
    end

    false
  end

  def is_this_association_filtered(to_filter:, symbol:, association:)
    arr = to_filter[symbol]
    arr.present? && arr.any? { |a| a == association.name }
  end
end

# Model class
class Model < ActiveRecord::Base
  include IdsOfAllDependencies
  include IdsOfAllDependenciesJson

  self.abstract_class = true

  def attributes_without_id
    self.attributes.reject{|k, v| k == "id"}
  end
end

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'abuse', 'abuses'
end
