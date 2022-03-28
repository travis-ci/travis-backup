# frozen_string_literal: true

require 'model'

class Job < Model
  self.inheritance_column = :_type_disabled

  belongs_to :source, polymorphic: true
  belongs_to :owner, polymorphic: true
  belongs_to :repository
  belongs_to :commit
  belongs_to :stage
  belongs_to :job_config, foreign_key: :config_id, class_name: 'JobConfig'
  has_many   :queueable_jobs
  has_many   :job_versions
end
