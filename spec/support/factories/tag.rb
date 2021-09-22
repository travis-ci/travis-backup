# frozen_string_literal: true

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
  end
end
