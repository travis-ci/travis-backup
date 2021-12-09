# frozen_string_literal: true

require 'model'

class Membership < Model
  belongs_to :organization
  belongs_to :user
  self.table_name = 'memberships'
end
