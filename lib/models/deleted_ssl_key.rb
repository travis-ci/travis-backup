# frozen_string_literal: true

require 'model'

class DeletedSslKey < Model
  belongs_to :repository
end