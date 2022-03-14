# frozen_string_literal: true

require 'model'

class Repository < Model
  belongs_to :owner, polymorphic: true
  belongs_to :current_build, foreign_key: :current_build_id, class_name: 'Build'
  belongs_to :last_build, foreign_key: :last_build_id, class_name: 'Build'
  has_many :builds, -> { order('id') }
  has_many :requests, -> { order('id') }, dependent: :destroy
  has_many :jobs
  has_many :branches
  has_many :ssl_keys
  has_many :commits
  has_many :permissions
  has_many :stars
  has_many :pull_requests
  has_many :tags
  has_many :build_configs
  has_many :email_unsubscribers
  has_many :request_configs
  has_many :job_configs
  has_many :request_raw_configs
  has_many :repo_counts
  has_many :request_yaml_configs

  has_many :deleted_builds
  has_many :deleted_requests
  has_many :deleted_jobs
  has_many :deleted_ssl_keys
  has_many :deleted_commits
  has_many :deleted_pull_requests
  has_many :deleted_tags
  has_many :deleted_build_configs
  has_many :deleted_request_configs
  has_many :deleted_job_configs
  has_many :deleted_request_raw_configs
  has_many :deleted_request_yaml_configs
end
