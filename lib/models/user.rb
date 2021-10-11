# frozen_string_literal: true

require 'model'

class User < Model
  has_many :builds_for_that_this_user_is_owner, as: :owner, class_name: 'Build'
  has_many :builds_for_that_this_user_is_sender, as: :sender, class_name: 'Build'
  has_many :repositories, as: :owner
  has_many :jobs, as: :owner
  has_many :requests_for_that_this_user_is_owner, as: :owner, class_name: 'Request'
  has_many :abuses, as: :owner
  has_many :subscriptions, as: :owner
  has_many :owner_groups, as: :owner
  has_many :trials, as: :owner
  has_many :trial_allowances, as: :creator
  has_many :broadcasts, as: :recipient
  has_many :requests_for_that_this_user_is_sender, as: :sender, class_name: 'Request'

  has_many :stars
  has_many :permissions
  has_many :tokens
  has_many :emails
  has_many :memberships
  has_many :user_beta_features

  self.table_name = 'users'
end
