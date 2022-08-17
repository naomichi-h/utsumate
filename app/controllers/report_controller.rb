class ReportController < ApplicationController
  before_action :authenticate_user!

  def new
    render :index
  end

  def index
    start_date = report_date.beginning_of_month.to_s
    end_date = report_date.end_of_month.to_s
    @logs_for_1month = Log.fixed_period(start_date, end_date)
    sleeps = @logs_for_1month.map(&:sleep)
    meals = @logs_for_1month.map(&:meal)
    medicines = @logs_for_1month.map(&:medicine)
    bathes = @logs_for_1month.map(&:bathe)
    go_outs = @logs_for_1month.map(&:go_out)

    @report = {
      #チャート表示最終日に1日追加することでチャートを綺麗に表示させる
      chart_end_date: (report_date.end_of_month + 1).to_s,
      report_year: report_date.year.to_s,
      report_month: report_date.month.to_s,
      logs_for_1month: Log.fixed_period(start_date, end_date),
      sleeps_chart: @logs_for_1month.map{|h| h.values_at(:date, :sleep) },
      sleeps_average: (sleeps.sum.to_f/sleeps.length).round(1),
      meals_ratio: ratio_calc(meals, true),
      medicines_ratio: ratio_calc(medicines, true),
      bathes_voluntary_ratio: ratio_calc(bathes, 'voluntary'),
      bathes_prompted_ratio: ratio_calc(bathes, 'prompted'),
      go_outs_alone_ratio: ratio_calc(go_outs, 'alone'),
      go_outs_with_someone_ratio: ratio_calc(go_outs, 'with_someone'),
      memos: @logs_for_1month.map{|h| h.values_at(:date, :memo) }
    }
  end

  private

  def report_date
    Date.new params["report_date(1i)"].to_i,params["report_date(2i)"].to_i
  end

  def ratio_calc(attribute, data)
    ((attribute.count(data).to_f/attribute.length)*100).round(1)
  end
end
