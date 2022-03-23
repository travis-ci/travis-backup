# frozen_string_literal: true

require 'models/deleted_request_raw_config'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_request_raw_config do
    key { 'some_test_key' }
    sequence(:id) { |n| n }
  end
end