# frozen_string_literal: true

require 'models/job'
require 'factory_bot'

FactoryBot.define do
  factory :job do
    factory :job_with_logs do
      transient do
        logs_count { 2 }
      end
      after(:create) do |job, evaluator|
        create_list(
          :log,
          evaluator.logs_count,
          job_id: job.id,
          content: 'some log content',
          removed_by: nil,
          archiving: false,
          archive_verified: true,
          created_at: job.created_at,
          updated_at: job.updated_at
        )
      end
    end

    factory :job_orphaned_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :job_with_repository_id do
      repository_id { Repository.first.id }
    end

    factory :job_orphaned_on_commit_id do
      commit_id { 2_000_000_000 }
    end

    factory :job_with_commit_id do
      commit_id { Commit.first.id }
    end

    factory :job_orphaned_on_stage_id do
      stage_id { 2_000_000_000 }
    end

    factory :job_with_stage_id do
      stage_id { Stage.first.id }
    end

    factory :job_with_all_dependencies do
      after(:create) do |job|
        create_list(
          :annotation, 2,
          job_id: job.id,
          created_at: job.created_at,
          updated_at: job.updated_at
        )
        create_list(
          :queueable_job, 2,
          job_id: job.id
        )
        create_list(
          :log, 2,
          job_id: job.id,
          created_at: job.created_at,
          updated_at: job.updated_at
        )
      end
      factory :job_with_all_dependencies_and_sibling do
        after(:create) do |job|
          create(:job, job.attributes_without_id.symbolize_keys)
        end
      end
    end
  end
end
