# frozen_string_literal: true

require 'models/job'
require 'models/model'
require 'models/repository'

# Build model
class Build < Model
  belongs_to :repository
  has_many   :jobs, -> { order('id') }, foreign_key: :source_id, dependent: :delete_all, class_name: 'Job'

  self.table_name = 'builds'
end
