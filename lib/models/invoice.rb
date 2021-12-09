# frozen_string_literal: true

require 'model'

class Invoice < Model
  belongs_to :subscription
  self.table_name = 'invoices'
end
