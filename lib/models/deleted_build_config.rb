# frozen_string_literal: true

require 'model'

class DeletedBuildConfig < Model
  belongs_to :repository
  # has_many :builds, foreign_key: :config_id, class_name: 'Build'
  # has_many :deleted_builds, foreign_key: :config_id, class_name: 'DeletedBuild'
end
