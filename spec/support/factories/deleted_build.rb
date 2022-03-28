# frozen_string_literal: true

require 'models/deleted_build'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_build do
    sequence(:id) { |n| n }
  end
end