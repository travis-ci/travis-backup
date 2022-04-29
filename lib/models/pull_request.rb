# frozen_string_literal: true

require 'model'

class PullRequest < Model
  self.inheritance_column = :_type_disabled

  belongs_to :repository
  has_many :requests
  has_many :builds
  has_many :deleted_requests
  has_many :deleted_builds
end
