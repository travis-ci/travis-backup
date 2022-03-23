# frozen_string_literal: true

require 'models/request_raw_config'
require 'factory_bot'

FactoryBot.define do
  factory :request_raw_config do
    key { 'some_test_key' }

    factory :request_raw_config_with_all_dependencies do
      after(:create) do |request_raw_config|
        create_list(
          :request_raw_configuration, 2,
          request_raw_config_id: request_raw_config.id
        )
        create_list(
          :deleted_request_raw_configuration, 2,
          request_raw_config_id: request_raw_config.id
        )
      end

      factory :request_raw_config_with_all_dependencies_and_sibling do
        after(:create) do |request_raw_config|
          create(:request_raw_config, request_raw_config.attributes_without_id.symbolize_keys)
        end
      end        
    end
  end
end