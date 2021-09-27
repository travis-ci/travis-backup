# frozen_string_literal: true

require 'active_record'

# Model class
class Model < ActiveRecord::Base
  self.abstract_class = true
  def attributes_without_id
    self.attributes.reject{|k, v| k == "id"}
  end
end
