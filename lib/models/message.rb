# frozen_string_literal: true

require 'model'

class Message < Model
  belongs_to :subject, polymorphic: true
end
