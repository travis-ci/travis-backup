# frozen_string_literal: true

require 'models/abuse'
require 'factory_bot'

FactoryBot.define do
  factory :abuse do
    level { 0 }
    reason { 'some text' }
  end
end
