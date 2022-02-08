# frozen_string_literal: true

FactoryBot.define do
  factory :log do
    user_id { '' }
    date { '2022-02-08' }
    sleep { 1 }
    meal { false }
    medicine { false }
    bathe { 'MyString' }
    go_out { 'MyString' }
    memo { 'MyText' }
  end
end
