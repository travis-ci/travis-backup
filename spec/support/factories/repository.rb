# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :repository do
    factory :repository_with_builds_jobs_and_logs do
      transient do
        builds_count { 2 }
      end
      after(:create) do |repository, evaluator|
        create_list(
          :build_with_jobs_and_logs,
          evaluator.builds_count,
          repository: repository,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
      end
    end

    factory :repository_with_builds do
      transient do
        builds_count { 2 }
      end
      after(:create) do |repository, evaluator|
        create_list(
          :build,
          evaluator.builds_count,
          repository: repository,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
      end
    end

    factory :repository_orphaned_on_current_build_id do
      current_build_id { 2_000_000_000 }
    end

    factory :repository_with_current_build_id do
      current_build_id { Build.first.id }
    end

    factory :repository_orphaned_on_last_build_id do
      last_build_id { 2_000_000_000 }
    end

    factory :repository_with_last_build_id do
      last_build_id { Build.first.id }
    end

    factory :repository_with_requests do
      transient do
        requests_count { 2 }
      end
      after(:create) do |repository, evaluator|
        create_list(
          :request,
          evaluator.requests_count,
          repository: repository,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
      end
    end

    factory :repository_with_all_dependencies do
      after(:create) do |repository|
        create_list(
          :build_with_all_dependencies, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :request_with_all_dependencies, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :job_with_all_dependencies, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :branch_with_all_dependencies, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :commit_with_all_dependencies, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :ssl_key, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :permission, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :star, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :pull_request_with_all_dependencies, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :tag_with_all_dependencies, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
      end
    end
    factory :repository_with_safe_dependencies do
      after(:create) do |repository|
        create_list(
          :build, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :request, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :job_with_all_dependencies, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :branch, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :commit, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :ssl_key, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :permission, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :star, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :pull_request, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create_list(
          :tag, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
      end
    end
  end
end
