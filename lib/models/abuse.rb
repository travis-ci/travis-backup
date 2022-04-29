# frozen_string_literal: true

require 'model'

class Abuse < Model
  self.inheritance_column = :_type_disabled

  belongs_to :owner, polymorphic: true
  belongs_to :request
end
