# frozen_string_literal: true

require 'model'

class EmailUnsubscribe < Model
  self.inheritance_column = :_type_disabled

  belongs_to :repository
  belongs_to :user
end
