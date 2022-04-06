class ReportController < ApplicationController
  def new
    render :index
  end

  def index
    @logs = Log.where('date >= ?', params[:report_start_date])
    @sleeps = @logs.map(&:sleep)
    if params[:start_date]
      chart_start_date = params[:start_date].to_date.beginning_of_month.to_s
      chart_end_date = params[:start_date].to_date.end_of_month.to_s
    else
      chart_start_date = Date.today.beginning_of_month.to_s
      chart_end_date = Date.today.end_of_month.to_s
    end
    @sleeps_chart = @logs.where('date >= ?', chart_start_date).where('date <= ?', chart_end_date).map{|h| h.values_at(:date, :sleep) }
    unless @sleeps_chart.find{|arr| arr[0] == chart_end_date.to_date}
      @sleeps_chart.push([chart_end_date, 0])
    end
    @sleeps_average = (@sleeps.sum.to_f/@sleeps.length).round(1)
    @meals = @logs.map(&:meal)
    @meals_ratio = ((@meals.count(true).to_f/@meals.length)*100).round(1)
    @medicines = @logs.map(&:medicine)
    @medicines_ratio = ((@medicines.count(true).to_f/@medicines.length)*100).round(1)
    @bathes = @logs.map(&:bathe)
    @bathes_voluntary_ratio = ((@bathes.count("voluntary").to_f/@bathes.length)*100).round(1)
    @bathes_prompted_ratio = ((@bathes.count("prompted").to_f/@bathes.length)*100).round(1)
    @go_outs = @logs.map(&:go_out)
    @go_outs_alone_ratio = ((@go_outs.count("alone").to_f/@bathes.length)*100).round(1)
    @go_outs_with_someone_ratio = ((@go_outs.count("with_someone").to_f/@go_outs.length)*100).round(1)
    @memos = @logs.map(&:memo)
    render :index
  end

  private

  def user_params
    params.require(:log).permit(:start_date)
  end
end
