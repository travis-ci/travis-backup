# frozen_string_literal: true

require 'model'

class DeletedRequestPayload < Model
  self.inheritance_column = :_type_disabled

  belongs_to :request
  self.primary_key = 'id'
end
