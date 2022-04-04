# frozen_string_literal: true

require 'model'

class DeletedStage < Model
  belongs_to :build
  self.primary_key = 'id'
end
