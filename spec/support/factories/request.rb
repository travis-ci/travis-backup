# frozen_string_literal: true

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
  end
end
