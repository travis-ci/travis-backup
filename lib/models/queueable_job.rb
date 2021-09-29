# frozen_string_literal: true

require 'model'

class QueueableJob < Model
  self.table_name = 'queueable_jobs'
end
