# frozen_string_literal: true

require 'models/tag'
require 'factory_bot'

FactoryBot.define do
  factory :tag do
    factory :tag_orphaned_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :tag_with_repository_id do
      repository_id { Repository.first.id }
    end

    factory :tag_orphaned_on_last_build_id do
      last_build_id { 2_000_000_000 }
    end

    factory :tag_with_last_build_id do
      last_build_id { Build.first.id }
    end

    factory :tag_with_all_dependencies do
      after(:create) do |tag|
        create(
          :build_with_safe_dependencies_and_sibling,
          tag_id: tag.id,
          created_at: tag.created_at,
          updated_at: tag.updated_at
        )
        create(
          :commit_with_all_dependencies_and_sibling,
          tag_id: tag.id,
          created_at: tag.created_at,
          updated_at: tag.updated_at
        )
        create(
          :request_with_all_dependencies_and_sibling,
          tag_id: tag.id,
          created_at: tag.created_at,
          updated_at: tag.updated_at
        )
        create_list(
          :deleted_build, 2,
          tag_id: tag.id,
          created_at: tag.created_at,
          updated_at: tag.updated_at
        )
        create_list(
          :deleted_commit, 2,
          tag_id: tag.id,
          created_at: tag.created_at,
          updated_at: tag.updated_at
        )
        create_list(
          :deleted_request, 2,
          tag_id: tag.id,
          created_at: tag.created_at,
          updated_at: tag.updated_at
        )
      end
      factory :tag_with_all_dependencies_and_sibling do
        after(:create) do |tag|
          create(:tag, tag.attributes_without_id.symbolize_keys)
        end
      end
    end
  end
end
