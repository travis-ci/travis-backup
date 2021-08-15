# frozen_string_literal: true

require 'models/model'
require 'models/repository'

# Job model
class Job < Model
  self.inheritance_column = :_type_disabled

  belongs_to :repository

  self.table_name = 'jobs'
end
