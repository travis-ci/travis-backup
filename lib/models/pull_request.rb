# frozen_string_literal: true

require 'model'

class PullRequest < Model
  has_many :requests
  has_many :builds

  self.table_name = 'pull_requests'
end
