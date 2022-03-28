# frozen_string_literal: true

require 'model'

class DeletedStage < Model
  belongs_to :build
  self.primary_key = 'id'
  # has_many :jobs
  # has_many :deleted_jobs
end
