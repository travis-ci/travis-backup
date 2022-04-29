# frozen_string_literal: true

require 'model'

class Email < Model
  self.inheritance_column = :_type_disabled

  belongs_to :user
end
