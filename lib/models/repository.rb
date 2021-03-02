# frozen_string_literal: true

require 'models/model'
require 'models/build'

# Repository model
class Repository < Model
  has_many :builds, -> { order('id') }, foreign_key: :repository_id, dependent: :destroy, class_name: 'Build'
  has_many :build_backup

  self.table_name = 'repositories'
end
