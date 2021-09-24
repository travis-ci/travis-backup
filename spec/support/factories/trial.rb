# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :trial do
    factory :trial_with_allowances do
      after(:create) do |trial|
        create_list(
          :trial_allowance, 2,
          trial_id: trial.id,
          created_at: trial.created_at,
          updated_at: trial.updated_at
        )
      end
    end
  end
end
