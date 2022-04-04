# frozen_string_literal: true

require 'model'

class DeletedRequestYamlConfig < Model
  belongs_to :repository
  self.primary_key = 'id'
end
