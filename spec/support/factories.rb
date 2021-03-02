# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :repository, class: Repository
  factory :build, class: Build
  factory :build_config, class: BuildConfig
  factory :job, class: Job
  factory :job_config, class: JobConfig
end
