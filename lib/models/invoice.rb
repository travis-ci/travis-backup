# frozen_string_literal: true

require 'model'

class Invoice < Model
  belongs_to :subscription
end
