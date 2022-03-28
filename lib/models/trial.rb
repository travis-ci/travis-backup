# frozen_string_literal: true

require 'model'

class Trial < Model
  belongs_to :owner, polymorphic: true
  has_many :trial_allowances
end
