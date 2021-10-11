# frozen_string_literal: true

require 'models/organization'
require 'factory_bot'

FactoryBot.define do
  factory :organization do
    factory :organization_with_repos do
      transient do
        repos_count { 3 }
      end
      after(:create) do |organization, evaluator|
        create_list(
          :repository_with_builds_jobs_and_logs,
          evaluator.repos_count,
          owner_id: organization.id,
          owner_type: 'Organization'
        )
      end
    end

    factory :organization_with_all_dependencies do
      after(:create) do |organization|
        create_list(
          :membership, 2,
          organization_id: organization.id,
        )
        create(
          :repository_with_all_dependencies_and_sibling,
          owner_id: organization.id,
          owner_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create(
          :build_with_all_dependencies_and_sibling,
          owner_id: organization.id,
          owner_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create(
          :build_with_all_dependencies_and_sibling,
          sender_id: organization.id,
          sender_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )

        repo = organization.repositories.first
        repo.update(current_build_id: organization.builds_for_that_this_organization_is_owner.second.id)
        repo.update(last_build_id: organization.builds_for_that_this_organization_is_sender.second.id)

        create(
          :request_with_all_dependencies_and_sibling,
          sender_id: organization.id,
          sender_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create(
          :request_with_all_dependencies_and_sibling,
          owner_id: organization.id,
          owner_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create(
          :job_with_all_dependencies_and_sibling,
          owner_id: organization.id,
          owner_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create_list(
          :subscription_with_invoices, 2,
          owner_id: organization.id,
          owner_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create_list(
          :trial_with_allowances, 2,
          owner_id: organization.id,
          owner_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create_list(
          :trial_allowance, 2,
          creator_id: organization.id,
          creator_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create_list(
          :owner_group, 2,
          owner_id: organization.id,
          owner_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create_list(
          :broadcast, 2,
          recipient_id: organization.id,
          recipient_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
        create_list(
          :abuse, 2,
          owner_id: organization.id,
          owner_type: 'Organization',
          created_at: organization.created_at,
          updated_at: organization.updated_at
        )
      end
    end
  end
end
