# frozen_string_literal: true

require 'models/model'

class OwnerGroup < Model
  belongs_to :owner, polymorphic: true
  self.table_name = 'owner_groups'
end
