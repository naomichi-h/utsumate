start_date = Date.new(2022, 8, 1)
end_date = Date.new(2022, 8, 31)
date = [*start_date.to_s..end_date.to_s]
sleep = [*3..12]
boolean = [true, false]
bathe = ['voluntary', 'prompted', false]
go_out = ['alone', 'with_someone', false]

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
      memo: date[n] + 'のメモ'
    }
  )
end