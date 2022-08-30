# frozen_string_literal: true

class ReportController < ApplicationController
  before_action :authenticate_user!

  def new
    render :index
  end

  def index
    @logs = Log.fixed_period(current_user_id, start_date, end_date)
    @report = Log.report_data(report_date, current_user_id, start_date, end_date)
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
end
