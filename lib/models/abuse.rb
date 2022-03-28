# frozen_string_literal: true

require 'model'

class Abuse < Model
  belongs_to :owner, polymorphic: true
  belongs_to :request
end
