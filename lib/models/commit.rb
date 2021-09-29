# frozen_string_literal: true

require 'model'

class Commit < Model
  has_many :builds
  has_many :jobs
  has_many :requests

  self.table_name = 'commits'
end
