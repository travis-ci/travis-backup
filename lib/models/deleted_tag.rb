# frozen_string_literal: true

require 'model'

class DeletedTag < Model
  self.inheritance_column = :_type_disabled

  belongs_to :last_build, foreign_key: :last_build_id, class_name: 'Build'
  belongs_to :repository
  self.primary_key = 'id'
end
