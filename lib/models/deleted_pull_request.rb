# frozen_string_literal: true

require 'model'

class DeletedPullRequest < Model
  belongs_to :repository
  self.primary_key = 'id'
end
