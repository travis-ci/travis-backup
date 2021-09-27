# frozen_string_literal: true

require 'models/model'
require 'models/build'
require 'models/request'

# Repository model
class Repository < Model
  has_many :builds, -> { order('id') }
  has_many :requests, -> { order('id') }, dependent: :destroy

  self.table_name = 'repositories'
end
