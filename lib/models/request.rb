# frozen_string_literal: true

require 'models/model'
require 'models/repository'

class Request < Model
  belongs_to :repository

  self.table_name = 'requests'
end
