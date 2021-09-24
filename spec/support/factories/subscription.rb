# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :subscription do
    factory :subscription_with_invoices do
      after(:create) do |subscription|
        create_list(
          :invoice, 2,
          subscription_id: tag.id,
          created_at: tag.created_at,
          updated_at: tag.updated_at
        )
      end
    end
  end
end
