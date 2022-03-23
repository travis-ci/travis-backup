# frozen_string_literal: true

require 'models/deleted_tag'
require 'factory_bot'

FactoryBot.define do
  factory :deleted_tag do
    # repository_id { 1 }
    # name { 'abc' }
    # last_build_id { 1 }
    # exists_on_github { false }
    # org_id { 1 }
    # com_id { 1 }
    sequence(:id) { |n| n }
  end
end