# frozen_string_literal: true

require 'model'

class Message < Model
  self.inheritance_column = :_type_disabled

  belongs_to :subject, polymorphic: true
end
