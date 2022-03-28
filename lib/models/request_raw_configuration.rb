# frozen_string_literal: true

require 'model'

class RequestRawConfiguration < Model
  belongs_to :request_raw_configs
  belongs_to :requests
end
