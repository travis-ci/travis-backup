# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :stage do
    factory :stage_orphaned_on_build_id do
      build_id { 2_000_000_000 }
    end

    factory :stage_with_build_id do
      build_id { Build.first.id }
    end
  end
end
