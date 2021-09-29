# frozen_string_literal: true

require 'models/model'

class Abuse < Model
  belongs_to :owner, polymorphic: true
  self.table_name = 'abuses'
end
