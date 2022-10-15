# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Log, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:log) { FactoryBot.create(:log) }
  let(:log_day1) { FactoryBot.create(:log, user: user, date: Date.new(2022, 8, 1), sleep: 4, meal: true, bathe: 'prompted') }
  let(:log_day2) { FactoryBot.create(:log, user: user, date: Date.new(2022, 8, 2), sleep: 3, meal: true, bathe: 'prompted') }
  let(:log_day3) { FactoryBot.create(:log, user: user, date: Date.new(2022, 8, 3), sleep: 8, meal: false, bathe: 'voluntary') }

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
    # 日時とユーザーを指定して任意のログが取得できるどうかのテスト
    it 'returns logs from start_date to end_date for the specified user' do
      expect(described_class.fixed_period(user.id, Date.new(2022, 8, 1), Date.new(2022, 8, 3))).to contain_exactly(log_day1, log_day2, log_day3)
    end
  end

  describe '.report_data' do
    # 日時とユーザーを指定して任意のレポートデータが取得できるどうかのテスト
    it 'returns report_data from start_date to end_date for the specified user' do
      logs = [log_day1, log_day2, log_day3]
      report_data = {
        chart_end_date: '2022-09-01',
        report_year: '2022',
        report_month: '8',
        logs: logs,
        sleeps_chart: logs.map { |h| h.values_at(:date, :sleep) },
        sleeps_average: described_class.average_calc(logs.map(&:sleep)),
        meals_ratio: described_class.ratio_calc(logs.map(&:meal), true),
        medicines_ratio: described_class.ratio_calc(logs.map(&:medicine), true),
        bathes_voluntary_ratio: described_class.ratio_calc(logs.map(&:bathe), 'voluntary'),
        bathes_prompted_ratio: described_class.ratio_calc(logs.map(&:bathe), 'prompted'),
        go_outs_alone_ratio: described_class.ratio_calc(logs.map(&:go_out), 'alone'),
        go_outs_with_someone_ratio: described_class.ratio_calc(logs.map(&:go_out), 'with_someone'),
        memos: logs.map { |h| h.values_at(:date, :memo) }
      }
      expect(described_class.report_data(Date.new(2022, 8), user.id, Date.new(2022, 8, 1), Date.new(2022, 8, 3))).to eq(report_data)
    end
  end

  describe '.average_calc' do
    it 'returns average value' do
      logs = [log_day1, log_day2, log_day3]
      expect(described_class.average_calc(logs.map(&:sleep))).to eq 5
    end
  end

  describe '.ratio_calc' do
    context 'with attributes that two choices' do
      it 'returns meal true ratio' do
        logs = [log_day1, log_day2, log_day3]
        expect(described_class.ratio_calc(logs.map(&:meal), true)).to eq 66.7
      end
    end

    context 'with attributes that three choices' do
      it 'returns bathe voluntary ratio' do
        logs = [log_day1, log_day2, log_day3]
        expect(described_class.ratio_calc(logs.map(&:bathe), 'voluntary')).to eq 33.3
      end
    end
  end

  describe '#start_time' do
    it 'calls the date attribute' do
      log = FactoryBot.build(:log)
      expect(log.start_time).to eq log.date
    end
  end

  describe '#medicine_answer' do
    context 'when the medicine attribute is true'
    it "returns '飲めた'" do
      log = FactoryBot.build(:log)
      expect(log.medicine_answer).to eq '飲めた'
    end

    context 'when the medicine attribute is false'
    it "returns '飲めなかった'" do
      log = FactoryBot.build(:log, medicine: false)
      expect(log.medicine_answer).to eq '飲めなかった'
    end
  end

  describe '#meal_answer' do
    context 'when the meal attribute is true'
    it "returns '摂れた'" do
      log = FactoryBot.build(:log)
      expect(log.meal_answer).to eq '摂れた'
    end

    context 'when the meal attribute is false'
    it "returns '摂れなかった'" do
      log = FactoryBot.build(:log, meal: false)
      expect(log.meal_answer).to eq '摂れなかった'
    end
  end

  describe '#bathe_answer' do
    context 'when the bathe attribute is voluntary'
    it "returns '自発的に入った'" do
      log = FactoryBot.build(:log)
      expect(log.bathe_answer).to eq '自発的に入った'
    end

    context 'when the bathe attribute is prompted'
    it "returns '促されて入った'" do
      log = FactoryBot.build(:log, bathe: 'prompted')
      expect(log.bathe_answer).to eq '促されて入った'
    end

    context 'when the bathe attribute is false'
    it "returns '入らなかった'" do
      log = FactoryBot.build(:log, bathe: 'did_not_bathe')
      expect(log.bathe_answer).to eq '入らなかった'
    end
  end

  describe '#go_out_answer' do
    context 'when the go_out attribute is alone'
    it "returns '一人で外出した'" do
      log = FactoryBot.build(:log)
      expect(log.go_out_answer).to eq '一人で外出した'
    end

    context 'when the go_out attribute is with_someone'
    it "returns '誰かと外出した'" do
      log = FactoryBot.build(:log, go_out: 'with_someone')
      expect(log.go_out_answer).to eq '誰かと外出した'
    end

    context 'when the go_out attribute is false'
    it "returns '外出しなかった'" do
      log = FactoryBot.build(:log, go_out: 'did_not_go_out')
      expect(log.go_out_answer).to eq '外出しなかった'
    end
  end
end
