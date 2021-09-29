# frozen_string_literal: true

require 'models/model'

class TrialAllowance < Model
  belongs_to :creator, polymorphic: true
  self.table_name = 'trial_allowances'
end
