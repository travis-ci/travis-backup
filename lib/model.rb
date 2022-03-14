# frozen_string_literal: true

require 'active_record'
require 'ids_of_all_dependencies'
require 'nullify_dependencies'

require 'models/abuse'
require 'models/beta_migration_request'
require 'models/branch'
require 'models/broadcast'
require 'models/build_config'
require 'models/build'
require 'models/cancellation'
require 'models/commit'
require 'models/cron'
require 'models/deleted_build_config'
require 'models/deleted_build'
require 'models/deleted_commit'
require 'models/deleted_job_config'
require 'models/deleted_pull_request'
require 'models/deleted_request_config'
require 'models/deleted_request_payload'
require 'models/deleted_request_raw_config'
require 'models/deleted_request_raw_configuration'
require 'models/deleted_request_yaml_config'
require 'models/deleted_request'
require 'models/deleted_ssl_key'
require 'models/deleted_stage'
require 'models/deleted_tag'
require 'models/email_unsubscriber'
require 'models/email'
require 'models/installation'
require 'models/invoice'
require 'models/job_config'
require 'models/job_version'
require 'models/job'
require 'models/membership'
require 'models/message'
require 'models/organization'
require 'models/owner_group'
require 'models/permission'
require 'models/pull_request'
require 'models/queueable_job'
require 'models/repo_count'
require 'models/repository'
require 'models/request_config'
require 'models/request_payload'
require 'models/request_raw_config'
require 'models/request_raw_configuration'
require 'models/request_yaml_config'
require 'models/request'
require 'models/ssl_key'
require 'models/stage'
require 'models/star'
require 'models/subscription'
require 'models/tag'
require 'models/token'
require 'models/trial_allowance'
require 'models/trial'
require 'models/user_beta_feature'
require 'models/user_utm_param'
require 'models/user'

class AssociationWithValue
  delegate_missing_to :@association

  def initialize(association, value)
    @association = association
    @value = value
  end
end

class Model < ActiveRecord::Base
  include IdsOfAllDependencies
  include NullifyDependencies

  self.abstract_class = true

  def attributes_without_id
    self.attributes.reject{|k, v| k == "id"}
  end

  def associations_hash
    self.associations.map do |association|
      [association.name, association]
    end.to_h
  end

  def associations
    self.class.reflect_on_all_associations.map do |association|
      value = self.send(association.name)
      AssociationWithValue.new(association, value)
    end
  end

  def associations_without_belongs_to
    self.associations.select { |a| a.macro != :belongs_to }
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

  def removed?
    begin
      reload
      false
    rescue ActiveRecord::RecordNotFound => e
      true
    end
  end
end

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'abuse', 'abuses'
end
