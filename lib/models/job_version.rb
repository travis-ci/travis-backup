# frozen_string_literal: true

require 'model'

class JobVersion < Model
  self.inheritance_column = :_type_disabled

  belongs_to :job
end
