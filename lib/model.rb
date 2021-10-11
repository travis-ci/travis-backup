# frozen_string_literal: true

require 'active_record'
require './utils'

module IdsOfAllDirectDependencies
  def ids_of_all_direct_dependencies
    result = {}

    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to

      symbol = association.klass.name.underscore.to_sym
      self.send(association.name).map do |associated_object|
        result[symbol] = [] if result[symbol].nil?
        result[symbol] << associated_object.id
      end
    end

    result
  end
end

module IdsOfAllDependenciesNested
  def ids_of_all_dependencies_nested(depth = Float::INFINITY)
    result = depth > 0 ? get_associations(depth) : {}
    result[:id] = id
    result = result[:id] if result.size == 1
    result
  end

  private

  def get_associations(depth)
    result = {}

    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to

      symbol = association.klass.name.underscore.to_sym
      self.send(association.name).map do |associated_object|
        result[symbol] = [] if result[symbol].nil?
        result[symbol] << associated_object.ids_of_all_dependencies_nested(depth - 1)
      end
    end

    result
  end
end

module IdsOfAllDependencies
  include IdsOfAllDependenciesNested
  include IdsOfAllDirectDependencies

  def ids_of_all_dependencies(to_filter=nil)
    ids_hash = ids_of_all_dependencies_without_reflection(to_filter || {})
    return ids_hash unless to_filter
    move_wrongly_assigned_to_main(to_filter, ids_hash)
  end

  def ids_of_all_dependencies_without_reflection(to_filter)
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

  def move_wrongly_assigned_to_main(to_filter, ids_hash)
    ids_hash[:filtered_out].each do |model_symbol, array|
      array.each do |id|
        object = Utils.get_model(model_symbol).find(id)
        move_object_to_main_if_necessary(to_filter[model_symbol], ids_hash, object)
      end
    end
    ids_hash
  end

  def move_object_to_main_if_necessary(associations_to_filter, ids_hash, object)
    if should_object_be_moved?(associations_to_filter, ids_hash, object)
      symbol = object.class.name.underscore.to_sym
      ids_hash[:filtered_out][symbol].delete(object.id)
      ids_hash[:main][symbol] = [] if ids_hash[:main][symbol].nil?
      ids_hash[:main][symbol] << object.id
    end
  end

  def should_object_be_moved?(associations_to_filter, ids_hash, object)
    associations_to_filter.map do |association|
      associated = object.send(association)

      associated.to_a.empty? || associated.map do |associated_object|
        class_symbol = associated_object.class.name.underscore.to_sym
        ids_hash[:main][class_symbol]&.include?(associated_object.id)
      end.reduce(:&)
    end.reduce(:&)
  end

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
      associated_object.ids_of_all_dependencies_without_reflection(to_filter)
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
      return true if object.send(association2.name).any? && is_this_association_filtered(**context)
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

  self.abstract_class = true

  def attributes_without_id
    self.attributes.reject{|k, v| k == "id"}
  end
end

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'abuse', 'abuses'
end
