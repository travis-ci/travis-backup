# frozen_string_literal: true

require 'model'

class DeletedRequestPayload < Model
  belongs_to :request
  self.primary_key = 'id'
end
