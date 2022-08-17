class ReportController < ApplicationController
  before_action :authenticate_user!

  def new
    render :index
  end

  def index
    if params[:start_date] # カレンダーで月を変えた時
      chart_start_date = params[:start_date].to_date.beginning_of_month.to_s
      @chart_end_date = params[:start_date].to_date.end_of_month.to_s
      @calendar_start_date = params[:start_date]
      @report_year = params[:start_date].to_date.year.to_s
      @report_month = params[:start_date].to_date.month.to_s
    else # 最初にうつレポ表示ボタンを押した時
      chart_start_date = report_date.beginning_of_month.to_s
      @chart_end_date = report_date.end_of_month.to_s
      @calendar_start_date = report_date.to_s
      @report_year = report_date.year.to_s
      @report_month = report_date.month.to_s
    end
    @logs_for_1month = Log.fixed_period(chart_start_date, @chart_end_date)
    @sleeps_chart = @logs_for_1month.map{|h| h.values_at(:date, :sleep) }
    sleeps = @logs_for_1month.map(&:sleep)
    @sleeps_average = (sleeps.sum.to_f/sleeps.length).round(1)
    meals = @logs_for_1month.map(&:meal)
    @meals_ratio = ratio_calc(meals, true)
    medicines = @logs_for_1month.map(&:medicine)
    @medicines_ratio = ratio_calc(medicines, true)
    bathes = @logs_for_1month.map(&:bathe)
    @bathes_voluntary_ratio = ratio_calc(bathes, 'voluntary')
    @bathes_prompted_ratio = ratio_calc(bathes, 'prompted')
    go_outs = @logs_for_1month.map(&:go_out)
    @go_outs_alone_ratio = ratio_calc(go_outs, 'alone')
    @go_outs_with_someone_ratio = ratio_calc(go_outs, 'with_someone')
    @memos = @logs_for_1month.map{|h| h.values_at(:date, :memo) }
    render :index
  end

  def show
    @logs_from_report_start_date = Log.where('date >= ?', params[:report_start_date]).order(:date)
    if params[:start_date] # カレンダーで月を変えた時
      chart_start_date = params[:start_date].to_date.beginning_of_month.to_s
      @chart_end_date = params[:start_date].to_date.end_of_month.to_s
      @report_year = params[:start_date].to_date.year.to_s
      @report_month = params[:start_date].to_date.month.to_s
    else # 最初に集計ボタンを押した時
      chart_start_date = Date.today.beginning_of_month.to_s
      @chart_end_date = Date.today.end_of_month.to_s
      @report_year = Date.today.year.to_s
      @report_month = Date.today.month.to_s
    end
    @logs_for_1month = @logs_from_report_start_date.where('date >= ?', chart_start_date).where('date <= ?', @chart_end_date)
    @sleeps_chart = @logs_for_1month.map{|h| h.values_at(:date, :sleep) }
    sleeps = @logs_for_1month.map(&:sleep)
    @sleeps_average = (sleeps.sum.to_f/sleeps.length).round(1)
    meals = @logs_for_1month.map(&:meal)
    @meals_ratio = ratio_calc(meals, true)
    medicines = @logs_for_1month.map(&:medicine)
    @medicines_ratio = ratio_calc(medicines, true)
    bathes = @logs_for_1month.map(&:bathe)
    @bathes_voluntary_ratio = ratio_calc(bathes, 'voluntary')
    @bathes_prompted_ratio = ratio_calc(bathes, 'prompted')
    go_outs = @logs_for_1month.map(&:go_out)
    @go_outs_alone_ratio = ratio_calc(go_outs, 'alone')
    @go_outs_with_someone_ratio = ratio_calc(go_outs, 'with_someone')
    @memos = @logs_for_1month.map{|h| h.values_at(:date, :memo) }
  end

  private

  def user_params
    params.require(:log).permit(:start_date)
  end

  def report_date
    # 年月日別々できたものを結合して新しいDate型変数を作って返す
    Date.new params["report_date(1i)"].to_i,params["report_date(2i)"].to_i
  end

  def ratio_calc(attribute, data)
    ((attribute.count(data).to_f/attribute.length)*100).round(1)
  end
end
