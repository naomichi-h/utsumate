# frozen_string_literal: true

FactoryBot.define do
  factory :log do
    date { '2022-08-01' }
    sleep { 7 }
    meal { 1 }
    medicine { 1 }
    bathe { 'voluntary' }
    go_out { 'alone' }
    memo { '2022年8月1日のメモ' }
    association :user
  end
end
