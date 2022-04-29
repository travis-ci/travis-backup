# frozen_string_literal: true

require 'model'

class OwnerGroup < Model
  self.inheritance_column = :_type_disabled

  belongs_to :owner, polymorphic: true
end
