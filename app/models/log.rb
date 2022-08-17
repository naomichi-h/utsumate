# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :user

  def start_time
    date
  end

  def self.fixed_period(start_date, end_date)
    Log.where('date >= ?', start_date).where('date <= ?', end_date)
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
    when :voluntary
      '自発的に入った'
    when :prompted
      '促されて入った'
    else
      '入らなかった'
    end
  end

  def go_out?
    case go_out
    when :alone
      '一人で外出した'
    when :with_someone
      '誰かと外出した'
    else
      '外出しなかった'
    end
  end
end
