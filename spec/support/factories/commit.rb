# frozen_string_literal: true

require 'models/build'
require 'factory_bot'

FactoryBot.define do
  factory :commit do
    factory :commit_orphaned_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :commit_with_repository_id do
      repository_id { Repository.first.id }
    end

    factory :commit_orphaned_on_branch_id do
      branch_id { 2_000_000_000 }
    end

    factory :commit_with_branch_id do
      branch_id { Branch.first.id }
    end

    factory :commit_orphaned_on_tag_id do
      tag_id { 2_000_000_000 }
    end

    factory :commit_with_tag_id do
      tag_id { Tag.first.id }
    end

    factory :commit_with_all_dependencies do
      after(:create) do |commit|
        create(
          :build_with_safe_dependencies_and_sibling,
          commit_id: commit.id,
          created_at: commit.created_at,
          updated_at: commit.updated_at
        )
        create(
          :job_with_all_dependencies_and_sibling,
          commit_id: commit.id,
          created_at: commit.created_at,
          updated_at: commit.updated_at
        )
        create(
          :request_with_all_dependencies_and_sibling,
          commit_id: commit.id,
          created_at: commit.created_at,
          updated_at: commit.updated_at
        )
        create_list(
          :deleted_build, 2,
          commit_id: commit.id,
          created_at: commit.created_at,
          updated_at: commit.updated_at
        )
        create_list(
          :deleted_job, 2,
          commit_id: commit.id,
          created_at: commit.created_at,
          updated_at: commit.updated_at
        )
        create_list(
          :deleted_request, 2,
          commit_id: commit.id,
          created_at: commit.created_at,
          updated_at: commit.updated_at
        )
      end
      factory :commit_with_all_dependencies_and_sibling do
        after(:create) do |commit|
          create(:commit, commit.attributes_without_id.symbolize_keys)
        end
      end
    end
  end
end
