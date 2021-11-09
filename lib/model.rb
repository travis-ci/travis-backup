# frozen_string_literal: true

require 'active_record'
require 'ids_of_all_dependencies'

# Model class
class Model < ActiveRecord::Base
  include IdsOfAllDependencies

  self.abstract_class = true

  def attributes_without_id
    self.attributes.reject{|k, v| k == "id"}
  end

  def self.get_model(name)
    self.subclasses.find{ |m| m.name == name.to_s.camelcase }
  end

  def self.get_model_by_table_name(name)
    self.subclasses.find{ |m| m.table_name == name.to_s }
  end

  def self.ids_of_subclasses_entries
    self.subclasses.map do |subclass|
      [subclass.name, subclass.all.map(&:id)] if subclass.any?
    end.compact.to_h
  end

  def self.sum_of_subclasses_rows(except: [])
    self.subclasses.map do |subclass|
      next 0 if except.include?(subclass.table_name) || except.include?(subclass.name)

      subclass.all.size
    end.reduce(:+)
  end
end

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'abuse', 'abuses'
end
