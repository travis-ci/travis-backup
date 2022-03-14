# frozen_string_literal: true

require 'model'

class RequestRawConfiguration < Model
  belongs_to :request_raw_configs
  has_many :requests
  has_many :deleted_requests
end
