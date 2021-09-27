# frozen_string_literal: true

require 'models/request'
require 'factory_bot'

FactoryBot.define do
  factory :request do
    factory :request_orphaned_on_commit_id do
      commit_id { 2_000_000_000 }
    end

    factory :request_with_commit_id do
      commit_id { Commit.first.id }
    end

    factory :request_orphaned_on_pull_request_id do
      pull_request_id { 2_000_000_000 }
    end

    factory :request_with_pull_request_id do
      pull_request_id { PullRequest.first.id }
    end

    factory :request_orphaned_on_branch_id do
      branch_id { 2_000_000_000 }
    end

    factory :request_with_branch_id do
      branch_id { Branch.first.id }
    end

    factory :request_orphaned_on_tag_id do
      tag_id { 2_000_000_000 }
    end

    factory :request_with_tag_id do
      tag_id { Tag.first.id }
    end

    factory :request_with_all_dependencies do
      after(:create) do |request|
        create_list(
          :abuse, 2,
          request_id: request.id,
          created_at: request.created_at,
          updated_at: request.updated_at
        )
        create_list(
          :message, 2,
          subject_id: request.id,
          subject_type: 'Request',
          created_at: request.created_at,
          updated_at: request.updated_at
        )
        create(
          :build_with_safe_dependencies_and_sibling,
          request_id: request.id,
          created_at: request.created_at,
          updated_at: request.updated_at
        )
      end
      factory :request_with_all_dependencies_and_sibling do
        after(:create) do |request|
          create(:request, request.attributes_without_id.symbolize_keys)
        end
      end
    end
  end
end
