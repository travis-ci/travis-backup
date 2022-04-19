# frozen_string_literal: true

require 'model'

class SslKey < Model
  self.inheritance_column = :_type_disabled

  belongs_to :repository
end
