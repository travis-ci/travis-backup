# frozen_string_literal: true

require 'model'

class DeletedBuild < Model
  belongs_to :repository
  belongs_to :owner, polymorphic: true
  belongs_to :sender, polymorphic: true
  belongs_to :related_branch, foreign_key: :branch_id, class_name: 'Branch'
  belongs_to :commit
  belongs_to :pull_request
  belongs_to :tag
  belongs_to :request
  belongs_to :build_config, foreign_key: :config_id, class_name: 'BuildConfig'
  self.primary_key = 'id'

  # has_many   :jobs, -> { order('id') }, as: :source, dependent: :destroy
  # has_many   :repos_for_that_this_build_is_current, foreign_key: :current_build_id, dependent: :destroy, class_name: 'Repository'
  # has_many   :repos_for_that_this_build_is_last, foreign_key: :last_build_id, class_name: 'Repository'
  # has_many   :tags_for_that_this_build_is_last, foreign_key: :last_build_id, class_name: 'Tag'
  # has_many   :branches_for_that_this_build_is_last, foreign_key: :last_build_id, class_name: 'Branch'
  # has_many   :stages

  # has_many   :deleted_jobs, -> { order('id') }, as: :source, dependent: :destroy
  # has_many   :deleted_tags_for_that_this_build_is_last, foreign_key: :last_build_id, class_name: 'DeletedTag'
  # has_many   :deleted_stages

  # def self.default_dependencies_symbols_to_nullify
  #   [
  #     :repos_for_that_this_build_is_current,
  #     :repos_for_that_this_build_is_last,
  #     :tags_for_that_this_build_is_last,
  #     :deleted_tags_for_that_this_build_is_last,
  #     :branches_for_that_this_build_is_last,
  #   ]
  # end
end
