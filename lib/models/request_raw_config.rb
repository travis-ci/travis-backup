# frozen_string_literal: true

require 'model'

class RequestRawConfig < Model
  belongs_to :repository
  has_many :request_raw_configurations
  has_many :deleted_request_raw_configurations
end
