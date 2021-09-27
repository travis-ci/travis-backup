# frozen_string_literal: true

require 'models/repository'
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
        create(
          :build_with_all_dependencies_and_sibling,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :request_with_all_dependencies_and_sibling,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :job_with_all_dependencies_and_sibling,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :branch_with_all_dependencies_and_sibling,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :commit_with_all_dependencies_and_sibling,
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
          repository_id: repository.id
        )
        create_list(
          :star, 2,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :pull_request_with_all_dependencies_and_sibling,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :tag_with_all_dependencies_and_sibling,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
      end
      factory :repository_with_all_dependencies_and_sibling do
        after(:create) do |repository|
          create(:repository, repository.attributes_without_id.symbolize_keys)
        end
      end
    end
    factory :repository_with_safe_dependencies do
      after(:create) do |repository|
        create(
          :build,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :request,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :job,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :branch,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :commit,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :ssl_key,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :permission,
          repository_id: repository.id
        )
        create(
          :star,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :pull_request,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
        create(
          :tag,
          repository_id: repository.id,
          created_at: repository.created_at,
          updated_at: repository.updated_at
        )
      end
      factory :repository_with_safe_dependencies_and_sibling do
        after(:create) do |repository|
          create(:repository, repository.attributes_without_id.symbolize_keys)
        end
      end
    end
  end
end
