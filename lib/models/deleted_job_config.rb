# frozen_string_literal: true

require 'model'

class DeletedJobConfig < Model
  belongs_to :repository
  self.primary_key = 'id'
  # has_many :jobs, foreign_key: :config_id, class_name: 'Job'
  # has_many :deleted_jobs, foreign_key: :config_id, class_name: 'DeletedJob'
end
