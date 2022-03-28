# frozen_string_literal: true

require 'model'

class Subscription < Model
  belongs_to :owner, polymorphic: true
  has_many :invoices
  has_many :cancellations
end
