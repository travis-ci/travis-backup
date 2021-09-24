# frozen_string_literal: true

require 'models/model'

class QueueableJob < Model
  self.table_name = 'queueable_jobs'
end
