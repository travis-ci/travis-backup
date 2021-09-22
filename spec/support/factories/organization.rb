# frozen_string_literal: true

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
  end
end
