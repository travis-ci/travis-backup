# frozen_string_literal: true

require 'model'

class QueueableJob < Model
  belongs_to :job
  self.table_name = 'queueable_jobs'
end
