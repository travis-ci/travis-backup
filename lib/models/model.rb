# frozen_string_literal: true

require 'active_record'

# Model class
class Model < ActiveRecord::Base
  self.abstract_class = true
end
