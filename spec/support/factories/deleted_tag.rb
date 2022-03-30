# frozen_string_literal: true

require 'models/deleted_tag'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_tag do
    sequence(:id) { |n| n }
  end
end