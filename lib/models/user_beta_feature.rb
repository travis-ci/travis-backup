# frozen_string_literal: true

require 'model'

class UserBetaFeature < Model
  self.inheritance_column = :_type_disabled

  belongs_to :user
end
