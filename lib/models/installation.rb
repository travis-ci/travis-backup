# frozen_string_literal: true

require 'model'

class Installation < Model
  belongs_to :owner, polymorphic: true
end
