# frozen_string_literal: true

require 'models/cron'
require 'factory_bot'

FactoryBot.define do
  factory :cron do
    interval { 'test' }
    factory :cron_orphaned_on_branch_id do
      branch_id { 2_000_000_000 }
    end

    factory :cron_with_branch_id do
      branch_id { Branch.first.id }
    end
  end
end
