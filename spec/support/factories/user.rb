# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :user do
    factory :user_with_repos do
      transient do
        repos_count { 3 }
      end
      after(:create) do |user, evaluator|
        create_list(
          :repository_with_builds_jobs_and_logs,
          evaluator.repos_count,
          owner_id: user.id,
          owner_type: 'User'
        )
      end
    end
  end
end
