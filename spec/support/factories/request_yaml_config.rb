# frozen_string_literal: true

require 'models/request_yaml_config'
require 'factory_bot'

FactoryBot.define do
  factory :request_yaml_config do
    key { 'some_test_key' }

    factory :request_yaml_config_with_all_dependencies do
      transient do
        created_at { nil }
        updated_at { nil }
      end

      after(:create) do |request_yaml_config, evaluator|
        create(
          :request_with_all_dependencies_and_sibling,
          config_id: request_yaml_config.id,
          created_at: evaluator.created_at,
          updated_at: evaluator.updated_at
        )
        create_list(
          :deleted_request, 2,
          config_id: request_yaml_config.id,
          created_at: evaluator.created_at,
          updated_at: evaluator.updated_at
        )
      end

      factory :request_yaml_config_with_all_dependencies_and_sibling do
        after(:create) do |request_yaml_config|
          create(:request_yaml_config, request_yaml_config.attributes_without_id.symbolize_keys)
        end
      end        
    end
  end
end