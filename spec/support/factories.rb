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
    factory :repository_with_builds_and_jobs do
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

    factory :orphan_repository_on_current_build_id do
      current_build_id { 2_000_000_000 }
    end

    factory :repository_with_current_build_id do
      current_build_id { Build.first.id }
    end

    factory :orphan_repository_on_last_build_id do
      last_build_id { 2_000_000_000 }
    end

    factory :repository_with_last_build_id do
      last_build_id { Build.first.id }
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

    factory :orphan_build_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :build_with_repository_id do
      repository_id { Repository.first.id }
    end

    factory :orphan_build_on_commit_id do
      commit_id { 2_000_000_000 }
    end

    factory :build_with_commit_id do
      commit_id { Commit.first.id }
    end

    factory :orphan_build_on_request_id do
      request_id { 2_000_000_000 }
    end

    factory :build_with_request_id do
      request_id { Request.first.id }
    end

    factory :orphan_build_on_pull_request_id do
      pull_request_id { 2_000_000_000 }
    end

    factory :build_with_pull_request_id do
      pull_request_id { PullRequest.first.id }
    end

    factory :orphan_build_on_branch_id do
      branch_id { 2_000_000_000 }
    end

    factory :build_with_branch_id do
      branch_id { Branch.first.id }
    end

    factory :orphan_build_on_tag_id do
      tag_id { 2_000_000_000 }
    end

    factory :build_with_tag_id do
      tag_id { Tag.first.id }
    end
  end

  factory :job do
    factory :orphan_job_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :job_with_repository_id do
      repository_id { Repository.first.id }
    end

    factory :orphan_job_on_commit_id do
      commit_id { 2_000_000_000 }
    end

    factory :job_with_commit_id do
      commit_id { Commit.first.id }
    end

    factory :orphan_job_on_stage_id do
      stage_id { 2_000_000_000 }
    end

    factory :job_with_stage_id do
      stage_id { Stage.first.id }
    end
  end

  factory :log do
    job_id { 1 }
    content { 'some log content' }
    removed_by { 1 }
    archiving { false }
    archive_verified { true }
  end

  factory :branch do
    name { "branch_#{Time.now.to_f}" }
    repository_id { 1 }
    factory :orphan_branch_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :orphan_branch_on_last_build_id do
      last_build_id { 2_000_000_000 }
    end

    factory :branch_with_last_build_id do
      last_build_id { Build.first.id }
    end
  end

  factory :tag do
    factory :orphan_tag_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :tag_with_repository_id do
      repository_id { Repository.first.id }
    end

    factory :orphan_tag_on_last_build_id do
      last_build_id { 2_000_000_000 }
    end

    factory :tag_with_last_build_id do
      last_build_id { Tag.first.id }
    end
  end

  factory :commit do
    factory :orphan_commit_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :commit_with_repository_id do
      repository_id { Repository.first.id }
    end

    factory :orphan_commit_on_branch_id do
      branch_id { 2_000_000_000 }
    end

    factory :commit_with_branch_id do
      branch_id { Branch.first.id }
    end

    factory :orphan_commit_on_tag_id do
      tag_id { 2_000_000_000 }
    end

    factory :commit_with_tag_id do
      tag_id { Tag.first.id }
    end
  end

  factory :cron do
    interval { 'test' }
    factory :orphan_cron_on_branch_id do
      branch_id { 2_000_000_000 }
    end

    factory :cron_with_branch_id do
      branch_id { Branch.first.id }
    end
  end

  factory :pull_request do
    factory :orphan_pull_request_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :pull_request_with_repository_id do
      repository_id { Repository.first.id }
    end
  end

  factory :ssl_key do
    factory :orphan_ssl_key_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :ssl_key_with_repository_id do
      repository_id { Repository.first.id }
    end
  end

  factory :request do
    factory :orphan_request_on_commit_id do
      commit_id { 2_000_000_000 }
    end

    factory :request_with_commit_id do
      commit_id { Commit.first.id }
    end

    factory :orphan_request_on_pull_request_id do
      pull_request_id { 2_000_000_000 }
    end

    factory :request_with_pull_request_id do
      pull_request_id { PullRequest.first.id }
    end

    factory :orphan_request_on_branch_id do
      branch_id { 2_000_000_000 }
    end

    factory :request_with_branch_id do
      branch_id { Branch.first.id }
    end

    factory :orphan_request_on_tag_id do
      tag_id { 2_000_000_000 }
    end

    factory :request_with_tag_id do
      tag_id { Tag.first.id }
    end
  end

  factory :stage do
    factory :orphan_stage_on_build_id do
      build_id { 2_000_000_000 }
    end

    factory :stage_with_build_id do
      build_id { Build.first.id }
    end
  end
end
