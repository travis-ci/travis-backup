# frozen_string_literal: true

require 'model'
require 'models/build'
require 'models/request'
require 'models/permission'
require 'models/star'

# Repository model
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

  self.table_name = 'repositories'
end
