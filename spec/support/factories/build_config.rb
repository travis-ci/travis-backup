# frozen_string_literal: true

require 'models/build_config'
require 'factory_bot'

FactoryBot.define do
  factory :build_config do
    key { 'some_test_key' }

    factory :build_config_with_all_dependencies do
      transient do
        created_at { nil }
        updated_at { nil }
      end

      after(:create) do |build_config, evaluator|
        create(
          :build_with_safe_dependencies_and_sibling,
          config_id: build_config.id,
          created_at: evaluator.created_at,
          updated_at: evaluator.updated_at
        )
        create_list(
          :deleted_build, 2,
          config_id: build_config.id,
          created_at: evaluator.created_at,
          updated_at: evaluator.updated_at
        )
      end

      factory :build_config_with_all_dependencies_and_sibling do
        after(:create) do |build_config|
          create(:build_config, build_config.attributes_without_id.symbolize_keys)
        end
      end
    end
  end
end