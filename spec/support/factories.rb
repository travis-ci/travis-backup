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
          :repository,
          evaluator.repos_count,
          owner_id: organization.id,
          owner_type: 'Organization'
        )
      end
    end
  end

  factory :user do
    factory :user_with_repos do
      transient do
        repos_count { 3 }
      end
      after(:create) do |user, evaluator|
        create_list(
          :repository,
          evaluator.repos_count,
          owner_id: user.id,
          owner_type: 'User'
        )
      end
    end
  end

  factory :repository do
    factory :repository_with_builds do
      transient do
        builds_count { 2 }
      end
      after(:create) do |repository, evaluator|
        create_list(
          :build_with_jobs,
          evaluator.builds_count,
          repository: repository,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
      end
    end

    factory :orphan_repository do
      current_build_id { 2_000_000_000 }
    end
  end

  factory :build do
    factory :build_with_jobs do
      transient do
        jobs_count { 2 }
      end
      after(:create) do |build, evaluator|
        create_list(
          :job,
          evaluator.jobs_count,
          repository: build.repository,
          source_type: 'Build',
          source_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
      end
    end
  end

  factory :job

  factory :log do
    job_id { 1 }
    content { 'some log content' }
    removed_by { 1 }
    archiving { false }
    archive_verified { true }
  end
end
