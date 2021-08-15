# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :repository, class: Repository
  factory :build, class: Build
  factory :job, class: Job
end
