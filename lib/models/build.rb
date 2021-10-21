# frozen_string_literal: true

require 'models/job'
require 'model'
require 'models/repository'

# Build model
class Build < Model
  belongs_to :repository
  belongs_to :owner, polymorphic: true
  belongs_to :sender, polymorphic: true
  belongs_to :branch
  belongs_to :commit
  belongs_to :pull_request
  belongs_to :tag
  belongs_to :request
  has_many   :jobs, -> { order('id') }, as: :source, dependent: :destroy
  has_many   :repos_for_that_this_build_is_current, foreign_key: :current_build_id, dependent: :destroy, class_name: 'Repository'
  has_many   :repos_for_that_this_build_is_last, foreign_key: :last_build_id, class_name: 'Repository'
  has_many   :tags_for_that_this_build_is_last, foreign_key: :last_build_id, class_name: 'Tag'
  has_many   :branches_for_that_this_build_is_last, foreign_key: :last_build_id, class_name: 'Branch'
  has_many   :stages

  self.table_name = 'builds'
end
