# frozen_string_literal: true

start_date = Date.new(2022, 10, 1)
end_date = Date.new(2022, 10, 31)
date = [*start_date.to_s..end_date.to_s]
sleep = [*3..12]
boolean = [true, false]
bathe = %w[voluntary prompted did_not_bathe]
go_out = %w[alone with_someone did_not_go_out]

31.times do |n|
  Log.seed(
    {
      id: n + 1,
      user_id: 1,
      date: date[n],
      sleep: sleep.sample,
      meal: boolean.sample,
      medicine: boolean.sample,
      bathe: bathe.sample,
      go_out: go_out.sample,
      memo: "#{date[n]}のメモ"
    }
  )
end
