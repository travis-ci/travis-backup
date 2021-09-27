# frozen_string_literal: true

require 'models/branch'
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

    factory :branch_with_all_dependencies do
      after(:create) do |branch|
        create(
          :build_with_safe_dependencies_and_sibling,
          branch_id: branch.id,
          created_at: branch.created_at,
          updated_at: branch.updated_at
        )
        create_list(
          :cron, 2,
          branch_id: branch.id,
          created_at: branch.created_at,
          updated_at: branch.updated_at
        )
        create(
          :job_with_all_dependencies_and_sibling,
          source_id: branch.id,
          source_type: 'Branch',
          created_at: branch.created_at,
          updated_at: branch.updated_at
        )
        create(
          :commit_with_all_dependencies_and_sibling,
          branch_id: branch.id,
          created_at: branch.created_at,
          updated_at: branch.updated_at
        )
        create(
          :request_with_all_dependencies_and_sibling,
          branch_id: branch.id,
          created_at: branch.created_at,
          updated_at: branch.updated_at
        )
      end
      factory :branch_with_all_dependencies_and_sibling do
        after(:create) do |branch|
          create(:branch, {
            **branch.attributes_without_id.symbolize_keys.reject {|k, v| k == :name},
            name: "branch_#{Time.now.to_f}_2"
          })
        end
      end
    end
  end
end
