# frozen_string_literal: true

require 'models/subscription'
require 'factory_bot'

FactoryBot.define do
  factory :subscription do
    factory :subscription_with_invoices do
      after(:create) do |subscription|
        create_list(
          :invoice, 2,
          subscription_id: subscription.id,
          created_at: subscription.created_at,
          updated_at: subscription.updated_at
        )
      end
    end
  end
end
