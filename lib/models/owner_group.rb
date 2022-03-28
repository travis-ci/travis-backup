# frozen_string_literal: true

require 'model'

class OwnerGroup < Model
  belongs_to :owner, polymorphic: true
end
