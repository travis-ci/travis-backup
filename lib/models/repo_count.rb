# frozen_string_literal: true

require 'model'

class RepoCount < Model
  belongs_to :repository
  self.primary_key = 'repository_id'
end
