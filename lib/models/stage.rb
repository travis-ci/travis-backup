# frozen_string_literal: true

require 'model'

class Stage < Model
  has_many :jobs

  self.table_name = 'stages'
end
