# frozen_string_literal: true

require 'models/model'
require 'models/repository'
require 'models/log'

# Job model
class Job < Model
  self.inheritance_column = :_type_disabled

  belongs_to :repository
  has_many   :logs, -> { order('id') }, dependent: :destroy

  self.table_name = 'jobs'
end
