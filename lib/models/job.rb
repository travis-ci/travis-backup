# frozen_string_literal: true

require 'models/job_config'
require 'models/model'

# Job model
class Job < Model
  self.inheritance_column = :_type_disabled

  belongs_to :job_config, foreign_key: :config_id, dependent: :destroy

  self.table_name = 'jobs'
end
