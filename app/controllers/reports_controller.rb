class ReportsController < ApplicationController
  def index
  end

  def aggregate
    @logs = params[:start_date]
    render :index
  end

  private

  def user_params
    params.require(:log).permit(:start_date)
  end
end
