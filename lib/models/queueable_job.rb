# frozen_string_literal: true

require 'model'

class QueueableJob < Model
  self.inheritance_column = :_type_disabled

  belongs_to :job
end
