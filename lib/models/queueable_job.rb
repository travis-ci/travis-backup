# frozen_string_literal: true

require 'model'

class QueueableJob < Model
  belongs_to :job
end
