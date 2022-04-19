# frozen_string_literal: true

require 'model'

class Invoice < Model
  self.inheritance_column = :_type_disabled

  belongs_to :subscription
end
