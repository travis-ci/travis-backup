# frozen_string_literal: true

require 'model'

class DeletedJobConfig < Model
  belongs_to :repository
  self.primary_key = 'id'
end
