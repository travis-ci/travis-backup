# frozen_string_literal: true

require 'models/model'
require 'models/build'
require 'models/request'

# Repository model
class Repository < Model
  has_many :builds, -> { order('id') }, foreign_key: :repository_id, class_name: 'Build'
  has_many :requests, -> { order('id') }, foreign_key: :repository_id, dependent: :destroy, class_name: 'Request'

  self.table_name = 'repositories'
end
