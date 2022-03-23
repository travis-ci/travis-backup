# frozen_string_literal: true

require 'models/deleted_build_config'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_build_config do
    key { 'some_test_key' }
    sequence(:id) { |n| n }
  end
end