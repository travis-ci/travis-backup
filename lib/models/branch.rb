# frozen_string_literal: true

require 'model'

class Branch < Model
  has_many :builds
  has_many :commits
  has_many :crons
  has_many :jobs, as: :source
  has_many :requests

  self.table_name = 'branches'
end
