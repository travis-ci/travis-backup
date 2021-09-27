# frozen_string_literal: true

require 'models/abuse'
require 'factory_bot'

FactoryBot.define do
  factory :abuse do
    sequence(:level) { |n| n }
    reason { 'some text' }
  end
end
