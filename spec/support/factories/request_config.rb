# frozen_string_literal: true

require 'models/request_config'
require 'factory_bot'

FactoryBot.define do
  factory :request_config do
    key { 'some_test_key' }

    factory :request_config_with_all_dependencies do
      transient do
        created_at { nil }
        updated_at { nil }
      end

      after(:create) do |request_config, evaluator|
        create(
          :request_with_all_dependencies_and_sibling,
          config_id: request_config.id,
          created_at: evaluator.created_at,
          updated_at: evaluator.updated_at
        )
        create_list(
          :deleted_request, 2,
          config_id: request_config.id,
          created_at: evaluator.created_at,
          updated_at: evaluator.updated_at
        )
      end

      factory :request_config_with_all_dependencies_and_sibling do
        after(:create) do |request_config|
          create(:request_config, request_config.attributes_without_id.symbolize_keys)
        end
      end        
    end
  end
end