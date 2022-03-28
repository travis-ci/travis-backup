# frozen_string_literal: true

require 'models/deleted_request_payload'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_request_payload do
    sequence(:id) { |n| n }
  end
end