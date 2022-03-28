# frozen_string_literal: true

require 'model'

class Email < Model
  belongs_to :user
end
