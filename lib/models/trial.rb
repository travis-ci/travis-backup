# frozen_string_literal: true

require 'model'

class Trial < Model
  self.inheritance_column = :_type_disabled

  belongs_to :owner, polymorphic: true
  has_many :trial_allowances
end
