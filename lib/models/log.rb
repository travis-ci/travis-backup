# frozen_string_literal: true

require 'models/model'

class Log < Model
  belongs_to :job

  self.table_name = 'logs'
end
