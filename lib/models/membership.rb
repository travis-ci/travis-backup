# frozen_string_literal: true

require 'model'

class Membership < Model
  self.inheritance_column = :_type_disabled

  belongs_to :organization
  belongs_to :user
end
