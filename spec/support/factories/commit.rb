# frozen_string_literal: true

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
  end
end
