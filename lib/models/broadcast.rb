# frozen_string_literal: true

require 'model'

class Broadcast < Model
  self.inheritance_column = :_type_disabled

  belongs_to :recipient, polymorphic: true
end
