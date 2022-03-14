# frozen_string_literal: true

require 'model'

class Broadcast < Model
  belongs_to :recipient, polymorphic: true
end
