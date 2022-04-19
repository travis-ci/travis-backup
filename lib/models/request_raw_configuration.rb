# frozen_string_literal: true

require 'model'

class RequestRawConfiguration < Model
  self.inheritance_column = :_type_disabled

  belongs_to :request_raw_configs
  belongs_to :requests
end
