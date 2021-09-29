# frozen_string_literal: true

require 'models/model'

class Subscription < Model
  belongs_to :owner, polymorphic: true
  has_many :invoices
  self.table_name = 'subscriptions'
end
