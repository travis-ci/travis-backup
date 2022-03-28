# frozen_string_literal: true

require 'models/deleted_stage'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_stage do
    sequence(:id) { |n| n }
  end
end