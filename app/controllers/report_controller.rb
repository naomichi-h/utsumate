class ReportController < ApplicationController
  def new
    render :index
  end

  def index
    @logs_from_report_start_date = Log.where('date >= ?', params[:report_start_date]).order(:date)
    if params[:start_date]
      chart_start_date = params[:start_date].to_date.beginning_of_month.to_s
      @chart_end_date = params[:start_date].to_date.end_of_month.to_s
    else
      chart_start_date = Date.today.beginning_of_month.to_s
      @chart_end_date = Date.today.end_of_month.to_s
    end
    @logs_for_1month = @logs_from_report_start_date.where('date >= ?', chart_start_date).where('date <= ?', @chart_end_date)
    @sleeps_chart = @logs_for_1month.map{|h| h.values_at(:date, :sleep) }
    sleeps = @logs_for_1month.map(&:sleep)
    @sleeps_average = (sleeps.sum.to_f/sleeps.length).round(1)
    meals = @logs_for_1month.map(&:meal)
    @meals_ratio = ((meals.count(true).to_f/meals.length)*100).round(1)
    medicines = @logs_for_1month.map(&:medicine)
    @medicines_ratio = ((medicines.count(true).to_f/medicines.length)*100).round(1)
    bathes = @logs_for_1month.map(&:bathe)
    @bathes_voluntary_ratio = ((bathes.count("voluntary").to_f/bathes.length)*100).round(1)
    @bathes_prompted_ratio = ((bathes.count("prompted").to_f/bathes.length)*100).round(1)
    go_outs = @logs_for_1month.map(&:go_out)
    @go_outs_alone_ratio = ((go_outs.count("alone").to_f/bathes.length)*100).round(1)
    @go_outs_with_someone_ratio = ((go_outs.count("with_someone").to_f/go_outs.length)*100).round(1)
    @memos = @logs_for_1month.map{|h| h.values_at(:date, :memo) }
    render :index
  end

  private

  def user_params
    params.require(:log).permit(:start_date)
  end
end
