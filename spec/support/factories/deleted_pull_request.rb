# frozen_string_literal: true

require 'models/deleted_pull_request'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_pull_request do
    sequence(:id) { |n| n }
  end
end