# frozen_string_literal: true

require 'models/model'
require 'models/repository'

# Build model
class BuildBackup < Model
  belongs_to :repository

  self.table_name = 'build_backups'
end
