# frozen_string_literal: true

require 'model'

class UserBetaFeature < Model
  belongs_to :user
  self.table_name = 'user_beta_features'
end
