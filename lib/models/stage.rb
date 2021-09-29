# frozen_string_literal: true

require 'models/model'

class Stage < Model
  has_many :jobs

  self.table_name = 'stages'
end
