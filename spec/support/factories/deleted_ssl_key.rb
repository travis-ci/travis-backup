# frozen_string_literal: true

require 'models/deleted_ssl_key'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_ssl_key do
    sequence(:id) { |n| n }
  end
end