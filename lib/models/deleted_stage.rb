# frozen_string_literal: true

require 'model'

class DeletedStage < Model
  self.inheritance_column = :_type_disabled

  belongs_to :build
  self.primary_key = 'id'
end
