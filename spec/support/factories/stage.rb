# frozen_string_literal: true

require 'models/stage'
require 'factory_bot'

FactoryBot.define do
  factory :stage do
    factory :stage_orphaned_on_build_id do
      build_id { 2_000_000_000 }
    end

    factory :stage_with_build_id do
      build_id { Build.first.id }
    end

    factory :stage_with_jobs do
      transient do
        created_at { nil }
        updated_at { nil }
      end
      after(:create) do |stage, evaluator|
        create_list(
          :job, 2,
          stage_id: stage.id,
          created_at: evaluator.created_at,
          updated_at: evaluator.updated_at
        )
      end
    end
  end
end
