# frozen_string_literal: true

require 'model'

class Cancellation < Model
  self.inheritance_column = :_type_disabled

  belongs_to :subscription
  belongs_to :user
end
