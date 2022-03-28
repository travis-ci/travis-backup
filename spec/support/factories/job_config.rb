# frozen_string_literal: true

require 'models/job_config'
require 'factory_bot'

FactoryBot.define do
  factory :job_config do
    key { 'some_test_key' }

    factory :job_config_with_all_dependencies do
      after(:create) do |job_config|
        create(
          :job_with_all_dependencies_and_sibling,
          config_id: job_config.id
        )
        create_list(
          :deleted_job, 2,
          config_id: job_config.id
        )
      end

      factory :job_config_with_all_dependencies_and_sibling do
        after(:create) do |job_config|
          create(:job_config, job_config.attributes_without_id.symbolize_keys)
        end
      end        
    end
  end
end