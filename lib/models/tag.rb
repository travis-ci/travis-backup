# frozen_string_literal: true

require 'model'

class Tag < Model
  has_many :builds
  has_many :commits
  has_many :requests

  self.table_name = 'tags'
end
