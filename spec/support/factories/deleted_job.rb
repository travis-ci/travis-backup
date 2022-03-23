# frozen_string_literal: true

require 'models/deleted_job'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_job do
    sequence(:id) { |n| n }
  end
end