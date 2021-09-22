# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :branch do
    name { "branch_#{Time.now.to_f}" }
    repository_id { 1 }
    factory :branch_orphaned_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :branch_orphaned_on_last_build_id do
      last_build_id { 2_000_000_000 }
    end

    factory :branch_with_last_build_id do
      last_build_id { Build.first.id }
    end
  end
end
