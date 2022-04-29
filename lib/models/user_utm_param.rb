# frozen_string_literal: true

require 'model'

class UserUtmParam < Model
  self.inheritance_column = :_type_disabled

  belongs_to :user
end
