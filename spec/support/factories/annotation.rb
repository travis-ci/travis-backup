# frozen_string_literal: true

require 'models/annotation'
require 'factory_bot'

FactoryBot.define do
  factory :annotation do
    description { 'some text' }
    annotation_provider_id { 0 }
  end
end
