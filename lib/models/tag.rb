# frozen_string_literal: true

require 'model'

class Tag < Model
  belongs_to :last_build, foreign_key: :last_build_id, class_name: 'Build'
  belongs_to :repository
  has_many :builds
  has_many :commits
  has_many :requests
  has_many :deleted_builds
  has_many :deleted_commits
  has_many :deleted_requests
end
