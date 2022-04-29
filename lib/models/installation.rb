# frozen_string_literal: true

require 'model'

class Installation < Model
  self.inheritance_column = :_type_disabled

  belongs_to :owner, polymorphic: true
end
