# frozen_string_literal: true

require 'model'
require 'models/repository'
require 'models/log'
require 'models/annotation'
require 'models/queueable_job'

# Job model
class Job < Model
  self.inheritance_column = :_type_disabled

  belongs_to :source, polymorphic: true
  belongs_to :owner, polymorphic: true
  belongs_to :repository
  belongs_to :commit
  belongs_to :stage
  has_many   :logs, -> { order('id') }, dependent: :destroy
  has_many   :annotations
  has_many   :queueable_jobs

  self.table_name = 'jobs'
end
