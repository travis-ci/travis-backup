# frozen_string_literal: true

require 'model'

class RequestConfig < Model
  belongs_to :repository
  has_many :requests, foreign_key: :config_id, class_name: 'Request'
  has_many :deleted_requests, foreign_key: :config_id, class_name: 'DeletedRequest'
end
