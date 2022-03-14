# frozen_string_literal: true

require 'model'

class Cancellation < Model
  belongs_to :subscription
  belongs_to :user
end
