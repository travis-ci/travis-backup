# frozen_string_literal: true

require 'model'

class DeletedBuild < Model
  self.inheritance_column = :_type_disabled

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
