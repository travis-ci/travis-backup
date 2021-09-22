# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :log do
    job_id { 1 }
    content { 'some log content' }
    removed_by { 1 }
    archiving { false }
    archive_verified { true }
  end
end
