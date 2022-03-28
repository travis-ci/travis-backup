# frozen_string_literal: true

require 'models/request_config'
require 'factory_bot'

FactoryBot.define do
  factory :request_config do
    key { 'some_test_key' }

    factory :request_config_with_all_dependencies do
      after(:create) do |request_config|
        create(
          :request_with_all_dependencies_and_sibling,
          config_id: request_config.id
        )
        create_list(
          :deleted_request, 2,
          config_id: request_config.id
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