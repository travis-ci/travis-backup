# frozen_string_literal: true

require 'model'

class DeletedRequestRawConfig < Model
  self.inheritance_column = :_type_disabled

  belongs_to :repository
  self.primary_key = 'id'
end
