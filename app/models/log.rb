# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :user
  validates :date, presence: true
  validates :date, uniqueness: { scope: :user_id }
  validates :sleep, presence: true
  validates :medicine, inclusion: [true, false]
  validates :meal, inclusion: [true, false]
  validates :bathe, presence: true
  validates :go_out, presence: true

  def self.fixed_period(user_id, start_date, end_date)
    Log.where(user_id: user_id).where('date >= ?', start_date).where('date <= ?', end_date)
  end

  def self.report_data(report_date, current_user_id, start_date, end_date)
    logs = Log.fixed_period(current_user_id, start_date, end_date)
    {
      # チャート表示最終日に1日追加することでチャートを綺麗に表示させる
      chart_end_date: (report_date.end_of_month + 1).to_s,
      report_year: report_date.year.to_s,
      report_month: report_date.month.to_s,
      logs: logs,
      sleeps_chart: logs.map { |h| h.values_at(:date, :sleep) },
      sleeps_average: average_calc(logs.map(&:sleep)),
      meals_ratio: ratio_calc(logs.map(&:meal), true),
      medicines_ratio: ratio_calc(logs.map(&:medicine), true),
      bathes_voluntary_ratio: ratio_calc(logs.map(&:bathe), 'voluntary'),
      bathes_prompted_ratio: ratio_calc(logs.map(&:bathe), 'prompted'),
      go_outs_alone_ratio: ratio_calc(logs.map(&:go_out), 'alone'),
      go_outs_with_someone_ratio: ratio_calc(logs.map(&:go_out), 'with_someone'),
      memos: logs.map { |h| h.values_at(:date, :memo) }
    }
  end

  # simple calendarでstart_time属性を持たないモデルを使用する場合に必要
  def start_time
    date
  end

  def medicine_answer
    if medicine
      '飲めた'
    else
      '飲めなかった'
    end
  end

  def meal_answer
    if meal
      '摂れた'
    else
      '摂れなかった'
    end
  end

  def bathe_answer
    case bathe
    when 'voluntary'
      '自発的に入った'
    when 'prompted'
      '促されて入った'
    when 'did_not_bathe'
      '入らなかった'
    else
      false
    end
  end

  def go_out_answer
    case go_out
    when 'alone'
      '一人で外出した'
    when 'with_someone'
      '誰かと外出した'
    when 'did_not_go_out'
      '外出しなかった'
    else
      false
    end
  end

  def self.average_calc(array)
    (array.sum.to_f / array.length).round(1)
  end

  def self.ratio_calc(attribute, data)
    ((attribute.count(data).to_f / attribute.length) * 100).round(1)
  end
end
