# frozen_string_literal: true

require 'model'

class BetaMigrationRequest < Model
  belongs_to :owner, polymorphic: true
  has_many :organizations
end
