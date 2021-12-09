# frozen_string_literal: true

require 'model'

class TrialAllowance < Model
  belongs_to :creator, polymorphic: true
  belongs_to :trial
  self.table_name = 'trial_allowances'
end
