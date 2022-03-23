# frozen_string_literal: true

require 'model'

class DeletedRequestConfig < Model
  belongs_to :repository
  self.primary_key = 'id'
  # has_many :requests, foreign_key: :config_id, class_name: 'Request'
  # has_many :deleted_requests, foreign_key: :config_id, class_name: 'DeletedRequest'
end
