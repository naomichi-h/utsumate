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

  # simple calendarでstart_time属性を持たないモデルを使用する場合に必要
  def start_time
    date
  end

  def medicine?
    if medicine
      '飲めた'
    else
      '飲めなかった'
    end
  end

  def meal?
    if meal
      '摂れた'
    else
      '摂れなかった'
    end
  end

  def bathe?
    case bathe
    when 'voluntary'
      '自発的に入った'
    when 'prompted'
      '促されて入った'
    else
      '入らなかった'
    end
  end

  def go_out?
    case go_out
    when 'alone'
      '一人で外出した'
    when 'with_someone'
      '誰かと外出した'
    else
      '外出しなかった'
    end
  end
end
