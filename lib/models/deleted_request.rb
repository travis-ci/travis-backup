# frozen_string_literal: true

require 'model'

class DeletedRequest < Model
  belongs_to :owner, polymorphic: true
  belongs_to :sender, polymorphic: true
  belongs_to :repository
  belongs_to :branch
  belongs_to :pull_request
  belongs_to :tag
  belongs_to :commit
  belongs_to :request_yaml_configs
  belongs_to :request_configs
  self.primary_key = 'id'
  # has_many :abuses
  # has_many :messages, as: :subject
  # has_many :jobs, as: :source
  # has_many :builds
  # has_many :request_payloads
  # has_many :request_raw_configurations
  # has_many :deleted_jobs, as: :source
  # has_many :deleted_builds
  # has_many :deleted_request_payloads
  # has_many :deleted_request_raw_configurations
end
