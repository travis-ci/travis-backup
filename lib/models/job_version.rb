# frozen_string_literal: true

require 'model'

class JobVersion < Model
  belongs_to :job
end
