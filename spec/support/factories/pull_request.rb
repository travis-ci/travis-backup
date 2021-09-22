# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :pull_request do
    factory :pull_request_orphaned_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :pull_request_with_repository_id do
      repository_id { Repository.first.id }
    end
  end
end
