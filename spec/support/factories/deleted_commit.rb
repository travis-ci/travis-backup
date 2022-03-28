# frozen_string_literal: true

require 'models/deleted_commit'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_commit do
    sequence(:id) { |n| n }
  end
end