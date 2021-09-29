# frozen_string_literal: true

require 'models/model'

class Trial < Model
  belongs_to :owner, polymorphic: true
  has_many :trial_allowances
  self.table_name = 'trials'
end
