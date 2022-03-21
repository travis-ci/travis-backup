# frozen_string_literal: true

require 'models/repository'
require 'factory_bot'

def create_for_repo(repository, what, how_many = 1)
  create_list(
    what, how_many,
    repository_id: repository.id,
    created_at: repository.created_at,
    updated_at: repository.updated_at
  )
end

FactoryBot.define do
  factory :repository do
    factory :repository_with_builds_jobs_and_logs do
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
        create_for_repo(repository, :build_with_all_dependencies_and_sibling)
        create_for_repo(repository, :request_with_all_dependencies_and_sibling)
        create_for_repo(repository, :job_with_all_dependencies_and_sibling)
        create_for_repo(repository, :branch_with_all_dependencies_and_sibling)
        create_for_repo(repository, :commit_with_all_dependencies_and_sibling)
        create_for_repo(repository, :ssl_key, 2)
        create_list(:permission, 2, repository_id: repository.id)
        create_for_repo(repository, :star, 2)
        create_for_repo(repository, :pull_request_with_all_dependencies_and_sibling)
        create_for_repo(repository, :tag_with_all_dependencies_and_sibling)
      end

      factory :repository_with_all_dependencies_and_sibling do
        after(:create) do |repository|
          create(:repository, repository.attributes_without_id.symbolize_keys)
        end
      end

      factory :repository_for_removing_heavy_data do
        created_at { 12.months.ago.to_time.utc }
        updated_at { 12.months.ago.to_time.utc }

        after(:create) do |repository|
          create_for_repo(repository, :build_for_removing_heavy_data)
          create(:build_for_removing_heavy_data, repository_id: repository.id)
          last_build = create_for_repo(repository, :build_for_removing_heavy_data).last
          create_for_repo(repository, :request)
          create(:request, repository_id: repository.id)

          repository.update(last_build_id: last_build.id)
        end
      end
    end

    factory :repository_with_safe_dependencies do
      after(:create) do |repository|
        create_for_repo(repository, :build)
        create_for_repo(repository, :request)
        create_for_repo(repository, :job)
        create_for_repo(repository, :branch)
        create_for_repo(repository, :commit)
        create_for_repo(repository, :ssl_key)
        create(:permission, repository_id: repository.id)
        create_for_repo(repository, :star)
        create_for_repo(repository, :pull_request)
        create_for_repo(repository, :tag)
      end

      factory :repository_with_safe_dependencies_and_sibling do
        after(:create) do |repository|
          create(:repository, repository.attributes_without_id.symbolize_keys)
        end
      end
    end
  end
end
