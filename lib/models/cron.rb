# frozen_string_literal: true

require 'model'

class Cron < Model
  belongs_to :branch
end
