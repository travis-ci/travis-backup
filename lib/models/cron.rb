# frozen_string_literal: true

require 'model'

class Cron < Model
  belongs_to :branch
  self.table_name = 'crons'
end
