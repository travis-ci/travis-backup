# frozen_string_literal: true

require 'models/model'
require 'models/job'
require 'models/build'

# Repository model
class Repository < Model
  has_many :build
  has_many :job

  self.table_name = 'repositories'
end
