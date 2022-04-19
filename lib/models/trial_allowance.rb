# frozen_string_literal: true

require 'model'

class TrialAllowance < Model
  self.inheritance_column = :_type_disabled

  belongs_to :creator, polymorphic: true
  belongs_to :trial
end
