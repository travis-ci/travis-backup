# frozen_string_literal: true

require 'model'

class SslKey < Model
  belongs_to :repository
end
