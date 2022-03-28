# frozen_string_literal: true

require 'model'

class DeletedRequestRawConfig < Model
  belongs_to :repository
  self.primary_key = 'id'
  # has_many :request_raw_configurations
  # has_many :deleted_request_raw_configurations
end
