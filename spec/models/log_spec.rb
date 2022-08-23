# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Log, type: :model do
  describe "valid_normal" do
    context 'all questions' do
      it "has a valid factory" do
        expect(FactoryBot.build(:log)).to be_valid
      end
    end

    context 'date' do
      it "allows two users to share a log date" do
        FactoryBot.create(:log)
        other_log = FactoryBot.build(:log)
        expect(other_log).to be_valid
      end
    end
  end

  describe "valid_error" do
    context 'date' do
      it "is invalid without date" do
        log = FactoryBot.build(:log, date: nil)
        log.valid?
        expect(log.errors[:date]).to include("の項目を入力してください")
      end

      it "does not allow duplicate log date per user" do
        user = FactoryBot.create(:user)

        user.logs.create(
          date: "2022-08-01",
          sleep: 7,
          meal: 1,
          medicine: 1,
          bathe: "voluntary",
          go_out: "alone",
          memo: "2022年8月1日のメモ"
        )

        new_log = user.logs.build(
          date: "2022-08-01",
          sleep: 7,
          meal: 1,
          medicine: 1,
          bathe: "voluntary",
          go_out: "alone",
          memo: "2022年8月1日のメモ"
        )

        new_log.valid?
        expect(new_log.errors[:date]).to include("の記録はすでに存在しています")
      end
    end

    context 'sleep' do
      it "is invalid without sleep" do
        log = FactoryBot.build(:log, sleep: nil)
        log.valid?
        expect(log.errors[:sleep]).to include("の項目を入力してください")
      end
    end

    context 'medicine' do
      it "is invalid without medicine" do
        log = FactoryBot.build(:log, medicine: nil)
        log.valid?
        expect(log.errors[:medicine]).to include("の項目を入力してください")
      end
    end

    context 'meal' do
      it "is invalid without meal" do
        log = FactoryBot.build(:log, meal: nil)
        log.valid?
        expect(log.errors[:meal]).to include("の項目を入力してください")
      end
    end

    context 'bathe' do
      it "is invalid without bathe" do
        log = FactoryBot.build(:log, bathe: nil)
        log.valid?
        expect(log.errors[:bathe]).to include("の項目を入力してください")
      end
    end

    context 'go_out' do
      it "is invalid without go_out" do
        log = FactoryBot.build(:log, go_out: nil)
        log.valid?
        expect(log.errors[:go_out]).to include("の項目を入力してください")
      end
    end
  end

  describe ".fixed_period" do
    it "returns logs from start_date to end_date for the specified user" do
      # 複数ユーザーが同一日付のログを持っている状態で、日時とユーザーを指定して任意のログが取得できるどうかのテスト
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)

      [*1..7].each { |n| FactoryBot.create(:log, user: user1, date: Date.new(2022, 8, n))}
      [*1..7].each { |n| FactoryBot.create(:log, user: user2, date: Date.new(2022, 8, n))}

      log1 = Log.where(user_id: user1.id).find_by(date: Date.new(2022, 8, 3))
      log2 = Log.where(user_id: user1.id).find_by(date: Date.new(2022, 8, 4))
      log3 = Log.where(user_id: user1.id).find_by(date: Date.new(2022, 8, 5))

      expect(Log.fixed_period(user1.id, Date.new(2022, 8, 3), Date.new(2022, 8, 5))).to contain_exactly(log1, log2, log3)
    end
  end

  describe "#start_time" do
    it "calls the date attribute" do
      log = FactoryBot.build(:log)
      expect(log.start_time).to eq log.date
    end
  end

  describe "#medicine?" do
    it "returns '飲めた' if the medicine attribute is true" do
      log = FactoryBot.build(:log)
      expect(log.medicine?).to eq '飲めた'
    end

    it "returns '飲めなかった' if the medicine attribute is false" do
      log = FactoryBot.build(:log, medicine: false)
      expect(log.medicine?).to eq '飲めなかった'
    end
  end

  describe "#meal?" do
    it "returns '摂れた' if the meal attribute is true" do
      log = FactoryBot.build(:log)
      expect(log.meal?).to eq '摂れた'
    end

    it "returns '摂れなかった' if the medicine attribute is false" do
      log = FactoryBot.build(:log, meal: false)
      expect(log.meal?).to eq '摂れなかった'
    end
  end

  describe "#bathe?" do
    it "returns '自発的に入った' if the bathe attribute is voluntary" do
      log = FactoryBot.build(:log)
      expect(log.bathe?).to eq '自発的に入った'
    end

    it "returns '促されて入った' if the bathe attribute is prompted" do
      log = FactoryBot.build(:log, bathe: 'prompted')
      expect(log.bathe?).to eq '促されて入った'
    end

    it "returns '入らなかった' if the bathe attribute is false" do
      log = FactoryBot.build(:log, bathe: false)
      expect(log.bathe?).to eq '入らなかった'
    end
  end

  describe "#go_out?" do
    it "returns '一人で外出した' if the go_out attribute is alone" do
      log = FactoryBot.build(:log)
      expect(log.go_out?).to eq '一人で外出した'
    end

    it "returns '誰かと外出した' if the go_out attribute is with_someone" do
      log = FactoryBot.build(:log, go_out: 'with_someone')
      expect(log.go_out?).to eq '誰かと外出した'
    end

    it "returns '外出しなかった' if the go_out attribute is false" do
      log = FactoryBot.build(:log, go_out: false)
      expect(log.go_out?).to eq '外出しなかった'
    end
  end

end
