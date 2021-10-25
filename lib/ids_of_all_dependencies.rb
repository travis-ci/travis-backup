require 'id_hash'

module IdsOfAllDirectDependencies
  def ids_of_all_direct_dependencies
    result = IdHash.new

    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to

      symbol = association.klass.name.underscore.to_sym
      self.send(association.name).map do |associated_object|
        result.add(symbol, associated_object.id)
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
      self.send(association.name).sort_by(&:id).map do |associated_object|
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
    ids_of_all_dependencies_with_filtered(to_filter)[:main]
  end

  def ids_of_all_dependencies_with_filtered(to_filter=nil)
    id_hash = ids_of_all_dependencies_without_reflection(to_filter || {})
    return id_hash unless to_filter
    move_wrongly_assigned_to_main(to_filter, id_hash)
  end

  def ids_of_all_dependencies_without_reflection(to_filter)
    result = { main: IdHash.new, filtered_out: IdHash.new }

    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to
      symbol = association.klass.name.underscore.to_sym
      context = { to_filter: to_filter, association: association }

      self.send(association.name).map do |associated_object|
        hash_to_use = get_hash_to_use(result, **context, object: associated_object)
        hash_to_use.add(symbol, associated_object.id)
      end
      result = get_result_with_grandchildren_hashes(result, context)
    end

    result
  end

  private

  def move_wrongly_assigned_to_main(to_filter, id_hash)
    id_hash[:filtered_out].each do |model_symbol, array|
      array.clone.each do |id|
        object = Model.get_model(model_symbol).find(id)
        move_object_to_main_if_necessary(to_filter[model_symbol], id_hash, object)
      end
    end
    id_hash
  end

  def move_object_to_main_if_necessary(associations_to_filter, id_hash, object)
    if should_object_be_moved?(associations_to_filter, id_hash, object)
      symbol = object.class.name.underscore.to_sym
      id_hash[:filtered_out][symbol].delete(object.id)
      id_hash[:main].add(symbol, object.id)
    end
  end

  def should_object_be_moved?(associations_to_filter, id_hash, object)
    associations_to_filter.map do |association|
      associated = object.send(association)

      associated.to_a.empty? || associated.map do |associated_object|
        class_symbol = associated_object.class.name.underscore.to_sym
        id_hash[:main][class_symbol]&.include?(associated_object.id)
      end.reduce(:&)
    end.reduce(:&)
  end

  def get_result_with_grandchildren_hashes(result, context)
    hashes = get_grandchildren_hashes(context)
    main = hashes.map { |hash| hash[:main] }
    filtered_out = hashes.map { |hash| hash[:filtered_out] }

    result[:main] =result[:main].join(*main)
    result[:filtered_out] = result[:filtered_out].join(*filtered_out)
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