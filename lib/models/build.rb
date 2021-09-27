# frozen_string_literal: true

require 'models/job'
require 'models/model'
require 'models/repository'

# Build model
class Build < Model
  belongs_to :repository
  has_many   :jobs, -> { order('id') }, foreign_key: :source_id, dependent: :destroy
  has_one    :repo_for_that_this_build_is_current, foreign_key: :current_build_id, dependent: :destroy, class_name: 'Repository'

  self.table_name = 'builds'
end
