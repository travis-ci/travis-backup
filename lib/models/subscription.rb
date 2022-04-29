# frozen_string_literal: true

require 'model'

class Subscription < Model
  self.inheritance_column = :_type_disabled

  belongs_to :owner, polymorphic: true
  has_many :invoices
  has_many :cancellations
end
