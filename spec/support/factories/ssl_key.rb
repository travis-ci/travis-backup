# frozen_string_literal: true

require 'models/ssl_key'
require 'factory_bot'

FactoryBot.define do
  factory :ssl_key do
    factory :ssl_key_orphaned_on_repository_id do
      repository_id { 2_000_000_000 }
    end

    factory :ssl_key_with_repository_id do
      repository_id { Repository.first.id }
    end
  end
end
