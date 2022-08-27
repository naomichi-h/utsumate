# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Log, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:log) { FactoryBot.create(:log) }

  describe 'valid_normal' do
    it 'has a valid factory' do
      expect(log).to be_valid
    end

    it 'allows two users to share a log date' do
      FactoryBot.create(:log)
      other_log = FactoryBot.build(:log)
      expect(other_log).to be_valid
    end
  end

  describe 'valid_error' do
    it 'is invalid without date' do
      log = FactoryBot.build(:log, date: nil)
      log.valid?
      expect(log.errors[:date]).to include('の項目を入力してください')
    end

    it 'does not allow duplicate log date per user' do
      FactoryBot.create(:log, user: user)

      new_log = FactoryBot.build(:log, user: user)

      new_log.valid?
      expect(new_log.errors[:date]).to include('の記録はすでに存在しています')
    end

    it 'is invalid without sleep' do
      log = FactoryBot.build(:log, sleep: nil)
      log.valid?
      expect(log.errors[:sleep]).to include('の項目を入力してください')
    end

    it 'is invalid without medicine' do
      log = FactoryBot.build(:log, medicine: nil)
      log.valid?
      expect(log.errors[:medicine]).to include('の項目を入力してください')
    end

    it 'is invalid without meal' do
      log = FactoryBot.build(:log, meal: nil)
      log.valid?
      expect(log.errors[:meal]).to include('の項目を入力してください')
    end

    it 'is invalid without bathe' do
      log = FactoryBot.build(:log, bathe: nil)
      log.valid?
      expect(log.errors[:bathe]).to include('の項目を入力してください')
    end

    it 'is invalid without go_out' do
      log = FactoryBot.build(:log, go_out: nil)
      log.valid?
      expect(log.errors[:go_out]).to include('の項目を入力してください')
    end
  end

  describe '.fixed_period' do
    let(:log_day1) { FactoryBot.create(:log, user: user, date: Date.new(2022, 8, 1)) }
    let(:log_day2) { FactoryBot.create(:log, user: user, date: Date.new(2022, 8, 2)) }
    let(:log_day3) { FactoryBot.create(:log, user: user, date: Date.new(2022, 8, 3)) }
    let(:log_day4) { FactoryBot.create(:log, user: user, date: Date.new(2022, 8, 4)) }
    let(:log_day5) { FactoryBot.create(:log, user: user, date: Date.new(2022, 8, 5)) }

    # 日時とユーザーを指定して任意のログが取得できるどうかのテスト
    it 'returns logs from start_date to end_date for the specified user' do
      expect(described_class.fixed_period(user.id, Date.new(2022, 8, 2), Date.new(2022, 8, 4))).to contain_exactly(log_day2, log_day3, log_day4)
    end
  end

  describe '#start_time' do
    it 'calls the date attribute' do
      log = FactoryBot.build(:log)
      expect(log.start_time).to eq log.date
    end
  end

  describe '#medicine?' do
    context 'when the medicine attribute is true'
    it "returns '飲めた'" do
      log = FactoryBot.build(:log)
      expect(log.medicine?).to eq '飲めた'
    end

    context 'when the medicine attribute is false'
    it "returns '飲めなかった'" do
      log = FactoryBot.build(:log, medicine: false)
      expect(log.medicine?).to eq '飲めなかった'
    end
  end

  describe '#meal?' do
    context 'when the meal attribute is true'
    it "returns '摂れた'" do
      log = FactoryBot.build(:log)
      expect(log.meal?).to eq '摂れた'
    end

    context 'when the meal attribute is false'
    it "returns '摂れなかった'" do
      log = FactoryBot.build(:log, meal: false)
      expect(log.meal?).to eq '摂れなかった'
    end
  end

  describe '#bathe?' do
    context 'when the bathe attribute is voluntary'
    it "returns '自発的に入った'" do
      log = FactoryBot.build(:log)
      expect(log.bathe?).to eq '自発的に入った'
    end

    context 'when the bathe attribute is prompted'
    it "returns '促されて入った'" do
      log = FactoryBot.build(:log, bathe: 'prompted')
      expect(log.bathe?).to eq '促されて入った'
    end

    context 'when the bathe attribute is false'
    it "returns '入らなかった'" do
      log = FactoryBot.build(:log, bathe: false)
      expect(log.bathe?).to eq '入らなかった'
    end
  end

  describe '#go_out?' do
    context 'when the go_out attribute is alone'
    it "returns '一人で外出した'" do
      log = FactoryBot.build(:log)
      expect(log.go_out?).to eq '一人で外出した'
    end

    context 'when the go_out attribute is with_someone'
    it "returns '誰かと外出した'" do
      log = FactoryBot.build(:log, go_out: 'with_someone')
      expect(log.go_out?).to eq '誰かと外出した'
    end

    context 'when the go_out attribute is false'
    it "returns '外出しなかった'" do
      log = FactoryBot.build(:log, go_out: false)
      expect(log.go_out?).to eq '外出しなかった'
    end
  end
end
