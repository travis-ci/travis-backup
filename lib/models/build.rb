# frozen_string_literal: true

require 'models/build_config'
require 'models/job'
require 'models/model'
require 'models/repository'

# Build model
class Build < Model
  belongs_to :repository
  belongs_to :build_config, foreign_key: :config_id, dependent: :delete_all
  has_many   :jobs, -> { order('id') }, foreign_key: :source_id, dependent: :delete_all, class_name: 'Job'

  self.table_name = 'builds'
end
