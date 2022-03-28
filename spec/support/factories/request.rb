# frozen_string_literal: true

require 'models/request'
require 'factory_bot'

def create_for_request(request, what, how_many = 1)
  create_list(
    what, how_many,
    request_id: request.id,
    created_at: request.created_at,
    updated_at: request.updated_at
  )
end

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
        create_for_request(request, :abuse, 2)
        create_list(
          :message, 2,
          subject_id: request.id,
          subject_type: 'Request',
          created_at: request.created_at,
          updated_at: request.updated_at
        )
        create_for_request(request, :build_with_safe_dependencies_and_sibling)
        create(
          :job_with_all_dependencies_and_sibling,
          source_type: 'Request',
          source_id: request.id,
          created_at: request.created_at,
          updated_at: request.updated_at
        )
        create_list(
          :request_payload, 2,
          request_id: request.id,
          created_at: request.created_at,
        )
        create_list(
          :request_raw_configuration, 2,
          request_id: request.id
        )
        create_list(
          :deleted_job, 2,
          source_type: 'Request',
          source_id: request.id,
          created_at: request.created_at,
          updated_at: request.updated_at
        )
        create_for_request(request, :deleted_build, 2)
        create_list(
          :deleted_request_payload, 2,
          request_id: request.id,
          created_at: request.created_at,
        )
        create_list(
          :deleted_request_raw_configuration, 2,
          request_id: request.id
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
