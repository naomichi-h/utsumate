# frozen_string_literal: true

class ReportController < ApplicationController
  before_action :authenticate_user!

  def new
    render :index
  end

  def index
    @logs = Log.fixed_period(current_user_id, start_date, end_date)
    @report = {
      # チャート表示最終日に1日追加することでチャートを綺麗に表示させる
      chart_end_date: (report_date.end_of_month + 1).to_s,
      report_year: report_date.year.to_s,
      report_month: report_date.month.to_s,
      logs: Log.fixed_period(current_user_id, start_date, end_date),
      sleeps_chart: attribute_date_map(:sleep),
      sleeps_average: average_calc(attribute_map(:sleep)),
      meals_ratio: ratio_calc(attribute_map(:meal), true),
      medicines_ratio: ratio_calc(attribute_map(:medicine), true),
      bathes_voluntary_ratio: ratio_calc(attribute_map(:bathe), 'voluntary'),
      bathes_prompted_ratio: ratio_calc(attribute_map(:bathe), 'prompted'),
      go_outs_alone_ratio: ratio_calc(attribute_map(:go_out), 'alone'),
      go_outs_with_someone_ratio: ratio_calc(attribute_map(:go_out), 'with_someone'),
      memos: attribute_date_map(:memo)
    }
  end

  private

  def current_user_id
    current_user.id
  end
  def report_date
    Date.new params['report_date(1i)'].to_i, params['report_date(2i)'].to_i
  end

  def start_date
    report_date.beginning_of_month.to_s
  end

  def end_date
    report_date.end_of_month.to_s
  end

  def attribute_map(attr)
    @logs.map(&attr)
  end

  def attribute_date_map(attr)
    @logs.map { |h| h.values_at(:date, attr) }
  end


  def average_calc(array)
    (array.sum.to_f / array.length).round(1)
  end

  def ratio_calc(attribute, data)
    ((attribute.count(data).to_f / attribute.length) * 100).round(1)
  end
end
