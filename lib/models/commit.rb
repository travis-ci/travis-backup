# frozen_string_literal: true

require 'model'

class Commit < Model
  belongs_to :related_branch, foreign_key: :branch_id, class_name: 'Branch'
  belongs_to :repository
  belongs_to :tag
  has_many :builds
  has_many :jobs
  has_many :requests

  self.table_name = 'commits'
end
