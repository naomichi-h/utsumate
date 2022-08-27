# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'alice' }
    sequence(:email) { |n| "alice#{n}@example.com" }
    password { 'password' }
  end
end
