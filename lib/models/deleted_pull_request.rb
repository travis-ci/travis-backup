# frozen_string_literal: true

require 'model'

class DeletedPullRequest < Model
  belongs_to :repository
  self.primary_key = 'id'
  # has_many :requests
  # has_many :builds
  # has_many :deleted_requests
  # has_many :deleted_builds
end
