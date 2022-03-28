# frozen_string_literal: true

require 'model'

class DeletedRequestRawConfiguration < Model
  belongs_to :request_raw_configs
  belongs_to :requests
  self.primary_key = 'id'
end
