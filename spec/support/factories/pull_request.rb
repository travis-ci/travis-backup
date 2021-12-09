# frozen_string_literal: true

require 'models/pull_request'
require 'factory_bot'

FactoryBot.define do
  factory :pull_request do
    factory :pull_request_orphaned_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :pull_request_with_repository_id do
      repository_id { Repository.first.id }
    end

    factory :pull_request_with_all_dependencies do
      after(:create) do |pull_request|
        create(
          :build_with_all_dependencies_and_sibling,
          pull_request_id: pull_request.id,
          created_at: pull_request.created_at,
          updated_at: pull_request.updated_at
        )
        create(
          :request_with_all_dependencies_and_sibling,
          pull_request_id: pull_request.id,
          created_at: pull_request.created_at,
          updated_at: pull_request.updated_at
        )
      end
      factory :pull_request_with_all_dependencies_and_sibling do
        after(:create) do |pull_request|
          create(:pull_request, pull_request.attributes_without_id.symbolize_keys)
        end
      end
    end
  end
end
