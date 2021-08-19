# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :repository do
    factory :repository_with_builds do
      transient do
        builds_count { 3 }
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
end
