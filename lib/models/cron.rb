# frozen_string_literal: true

require 'model'

class Cron < Model
  self.inheritance_column = :_type_disabled

  belongs_to :branch
end
