# frozen_string_literal: true

require 'model'

class DeletedStage < Model
  belongs_to :build
  # has_many :jobs
  # has_many :deleted_jobs
end