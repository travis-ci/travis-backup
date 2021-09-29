# frozen_string_literal: true

require 'models/model'
require 'models/repository'
require 'models/log'

# Job model
class Job < Model
  self.inheritance_column = :_type_disabled

  belongs_to :owner, polymorphic: true
  belongs_to :repository
  has_many   :logs, -> { order('id') }, dependent: :destroy
  has_many   :annotations
  has_many   :queueable_jobs

  self.table_name = 'jobs'
end
