require 'id_hash'

module SymbolsOfAllDirectDependencies
  def symbols_of_all_direct_dependencies
    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to

      association.name
    end.compact
  end
end

module IdsOfAllDirectDependencies
  include SymbolsOfAllDirectDependencies

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

module DependencyTree
  class Tree < Hash
    def initialize(hash={})
      hash.each do |key, value|
        self[key] = value
      end
    end

    def ids_tree
      self_cloned = self.deep_tree_clone
      self_cloned.delete_key_recursive(:instance)
    end

    def status_tree
      self_cloned = self.deep_tree_clone

      self_cloned.do_recursive do |tree|
        begin
          tree[:instance].reload
          tree[:status] = 'present'
        rescue ActiveRecord::RecordNotFound => e
          tree[:status] = 'removed'
        end

        tree.delete(:instance)
      end
    end

    def status_tree_condensed
      result = status_tree.do_recursive do |tree|
        tree.each do |name, array|
          next unless array.class == Array

          new_array = array.map do |subtree|
            next subtree.root_duplicate_summary if subtree[:duplicate]
            next subtree if subtree.class != Tree || subtree.size > 2

            subtree.root_summary
          end

          array.clear
          array.concat(new_array)
        end
      end

      result.do_recursive do |tree|
        tree[:_] = tree.root_summary
        tree.delete(:id)
        tree.delete(:status)
        tree.last_to_beginning!
      end
    end

    def last_to_beginning!
      arr = self.to_a
      arr.unshift(arr.pop)
      self.clear
      self.merge!(arr.to_h)
    end

    def root_summary
      "id #{self[:id]}, #{self[:status]}"
    end

    def root_duplicate_summary
      root_summary + ", duplicate"
    end

    def deep_tree_clone
      hash = self.clone.map do |key, array|
        next [key, array] unless array.class == Array

        new_array = array.map do |subtree|
          if subtree.class == Tree
            subtree.deep_tree_clone
          else
            subtree
          end
        end

        [key, new_array]
      end

      Tree.new(hash)
    end

    def delete_key_recursive(key)
      call_method_recursive(:delete, key)
    end

    def call_method_recursive(method, *args, &block)
      do_recursive do |tree|
        tree.send(method, *args, &block)
      end
    end

    def do_recursive(&block)
      block.call(self)

      self.each do |key, array|
        next unless array.is_a? Array

        array.each do |subtree|
          subtree.do_recursive(&block) if subtree.is_a? Tree
        end
      end

      self
    end
  end

  def dependency_tree(depth = Float::INFINITY, hash_for_duplication_check = IdHash.new)
    is_duplicate = hash_for_duplication_check[self.class]&.include?(id)
    hash_for_duplication_check.add(self.class, id)
    shoud_go_deeper = depth > 0 && !is_duplicate
    result = shoud_go_deeper ? get_associations_for_tree(depth, hash_for_duplication_check) : Tree.new
    result[:id] = id
    result[:instance] = self
    result[:duplicate] = true if is_duplicate
    result
  end

  private

  def get_associations_for_tree(depth, hash_for_duplication_check)
    result = Tree.new

    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to

      symbol = association.klass.name.underscore.to_sym
      self.send(association.name).sort_by(&:id).map do |associated_object|
        result[symbol] = [] if result[symbol].nil?
        result[symbol] << associated_object.dependency_tree(depth - 1, hash_for_duplication_check)
      end
    end

    result
  end
end

module IdsOfAllDependencies
  include IdsOfAllDependenciesNested
  include IdsOfAllDirectDependencies
  include DependencyTree

  def ids_of_all_dependencies(to_filter=nil, filtering_strategy=:with_parents)
    ids_of_all_dependencies_with_filtered(to_filter, filtering_strategy)[:main]
  end

  def ids_of_all_dependencies_with_filtered(to_filter=nil, filtering_strategy=:with_parents)
    id_hash = ids_of_all_dependencies_without_reflection(to_filter || {}, filtering_strategy)
    move_wrongly_assigned_to_main(to_filter, id_hash) if to_filter && filtering_strategy == :with_parents
    id_hash[:main].sort_arrays!
    id_hash[:filtered_out].sort_arrays!
    id_hash
  end

  def ids_of_all_dependencies_without_reflection(to_filter, filtering_strategy=:with_parents)
    result = { main: IdHash.new, filtered_out: IdHash.new }
    self_symbol = self.class.name.underscore.to_sym

    self.class.reflect_on_all_associations.map do |association|
      next if association.macro == :belongs_to
      symbol = association.klass.name.underscore.to_sym
      context = { to_filter: to_filter, self_symbol: self_symbol, association: association, strategy: filtering_strategy }

      self.send(association.name).map do |associated_object|
        hash_to_use = get_hash_to_use(result, **context, object: associated_object)
        hash_to_use.add(symbol, associated_object.id)
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

    result[:main] =result[:main].join(*main)
    result[:filtered_out] = result[:filtered_out].join(*filtered_out)
    result
  end

  def get_grandchildren_hashes(context)
    association = context[:association]
    to_filter = context[:to_filter]

    self.send(association.name).map do |associated_object|
      next if should_be_filtered?(**context, object: associated_object)
      associated_object.ids_of_all_dependencies_without_reflection(to_filter, context[:strategy])
    end.compact
  end

  def get_hash_to_use(result, context)
    symbol = should_be_filtered?(**context) ? :filtered_out : :main
    result[symbol]
  end

  def should_be_filtered?(context)
    case context[:strategy]
    when :with_parents
      should_be_filtered_according_to_with_parents_strategy?(context)
    when :without_parents
      should_be_filtered_according_to_without_parents_strategy?(context)
    end
  end

  def should_be_filtered_according_to_with_parents_strategy?(context)
    to_filter = context[:to_filter]
    object = context[:object]
    association = context[:association]
    symbol = association.klass.name.underscore.to_sym

    association.klass.reflect_on_all_associations.each do |association2|
      next if association2.macro == :belongs_to

      context = { to_filter: to_filter, symbol: symbol, association: association2 }
      return true if object.send(association2.name).any? && is_this_association_filtered?(**context)
    end

    false
  end

  def is_this_association_filtered?(to_filter:, symbol:, association:)
    arr = to_filter[symbol]
    arr.present? && arr.any? { |a| a == association.name }
  end

  def should_be_filtered_according_to_without_parents_strategy?(context)
    is_this_association_filtered?(
      to_filter: context[:to_filter],
      symbol: context[:self_symbol],
      association: context[:association]
    )
  end

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
end
