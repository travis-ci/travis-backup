# frozen_string_literal: true

require 'model'

class DeletedRequest < Model
  self.inheritance_column = :_type_disabled

  belongs_to :owner, polymorphic: true
  belongs_to :sender, polymorphic: true
  belongs_to :repository
  belongs_to :branch
  belongs_to :pull_request
  belongs_to :tag
  belongs_to :commit
  belongs_to :request_yaml_configs
  belongs_to :request_configs
  self.primary_key = 'id'
end
