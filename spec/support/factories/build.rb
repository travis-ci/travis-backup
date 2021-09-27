# frozen_string_literal: true

require 'models/build'
require 'factory_bot'

FactoryBot.define do
  factory :build do
    factory :build_with_jobs_and_logs do
      transient do
        jobs_count { 2 }
      end
      after(:create) do |build, evaluator|
        create_list(
          :job_with_logs,
          evaluator.jobs_count,
          repository: build.repository,
          source_type: 'Build',
          source_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
      end
    end

    factory :build_with_repo do
      after(:create) do |build|
        create(
          :repository,
          current_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
      end

      factory :build_orphaned_on_repository_id_with_mutually_related_repo do
        repository_id { 2_000_000_000 }
      end
    end

    factory :build_with_repository_id do
      repository_id { Repository.first.id }
    end

    factory :build_with_mutually_related_repo do
      after(:create) do |build|
        repo = create(
          :repository,
          current_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        build.repository_id = repo.id
        build.save!
      end

      factory :build_orphaned_on_commit_id_with_mutually_related_repo do
        commit_id { 2_000_000_000 }
      end        

      factory :build_orphaned_on_request_id_with_mutually_related_repo do
        request_id { 2_000_000_000 }
      end

      factory :build_orphaned_on_pull_request_id_with_mutually_related_repo do
        pull_request_id { 2_000_000_000 }
      end

      factory :build_orphaned_on_branch_id_with_mutually_related_repo do
        branch_id { 2_000_000_000 }
      end

      factory :build_orphaned_on_tag_id_with_mutually_related_repo do
        tag_id { 2_000_000_000 }
      end
    end

    factory :build_with_commit_id do
      commit_id { Commit.first.id }
    end

    factory :build_with_request_id do
      request_id { Request.first.id }
    end

    factory :build_with_pull_request_id do
      pull_request_id { PullRequest.first.id }
    end

    factory :build_with_branch_id do
      branch_id { Branch.first.id }
    end

    factory :build_with_tag_id do
      tag_id { Tag.first.id }
    end

    factory :build_with_all_dependencies do
      after(:create) do |build|
        create(
          :tag_with_all_dependencies_and_sibling,
          last_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create_list(
          :stage_with_jobs, 2,
          build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create(
          :job_with_all_dependencies_and_sibling,
          source_type: 'Build',
          source_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create(
          :branch_with_all_dependencies_and_sibling,
          last_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create(
          :repository_with_safe_dependencies_and_sibling,
          last_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create(
          :repository_with_safe_dependencies_and_sibling,
          current_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
      end
      factory :build_with_all_dependencies_and_sibling do
        after(:create) do |build|
          create(:build, build.attributes_without_id.symbolize_keys)
        end
      end
    end

    factory :build_with_safe_dependencies do
      after(:create) do |build|
        create_list(
          :tag, 2,
          last_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create_list(
          :stage_with_jobs, 2,
          build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create(
          :job_with_all_dependencies_and_sibling,
          source_type: 'Build',
          source_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create_list(
          :branch, 2,
          last_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create_list(
          :repository, 2,
          last_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
        create_list(
          :repository, 2,
          current_build_id: build.id,
          created_at: build.created_at,
          updated_at: build.updated_at
        )
      end
      factory :build_with_safe_dependencies_and_sibling do
        after(:create) do |build|
          create(:build, build.attributes_without_id.symbolize_keys)
        end
      end
    end
  end
end
