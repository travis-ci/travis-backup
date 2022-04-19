# frozen_string_literal: true

require 'model'

class Organization < Model
  self.inheritance_column = :_type_disabled

  belongs_to :beta_migration_request
  has_many :builds_for_that_this_organization_is_owner, as: :owner, class_name: 'Build'
  has_many :builds_for_that_this_organization_is_sender, as: :sender, class_name: 'Build'
  has_many :repositories, as: :owner
  has_many :jobs, as: :owner
  has_many :requests_for_that_this_organization_is_owner, as: :owner, class_name: 'Request'
  has_many :abuses, as: :owner
  has_many :subscriptions, as: :owner
  has_many :owner_groups, as: :owner
  has_many :trials, as: :owner
  has_many :trial_allowances, as: :creator
  has_many :broadcasts, as: :recipient
  has_many :requests_for_that_this_organization_is_sender, as: :sender, class_name: 'Request'
  has_many :memberships

  has_many :deleted_builds_for_that_this_organization_is_owner, as: :owner, class_name: 'DeletedBuild'
  has_many :deleted_builds_for_that_this_organization_is_sender, as: :sender, class_name: 'DeletedBuild'
  has_many :deleted_jobs, as: :owner
  has_many :deleted_requests_for_that_this_organization_is_owner, as: :owner, class_name: 'DeletedRequest'
  has_many :deleted_requests_for_that_this_organization_is_sender, as: :sender, class_name: 'DeletedRequest'
end
