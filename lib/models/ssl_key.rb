# frozen_string_literal: true

require 'model'

class SslKey < Model
  belongs_to :repository
  self.table_name = 'ssl_keys'
end
