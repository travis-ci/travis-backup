# frozen_string_literal: true

require 'model'

class RequestPayload < Model
  self.inheritance_column = :_type_disabled

  belongs_to :request
end
