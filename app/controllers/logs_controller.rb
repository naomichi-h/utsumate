# frozen_string_literal: true

class LogsController < ApplicationController
  before_action :authenticate_user!, :set_log, only: %i[show edit update destroy]

  # GET /logs or /logs.json
  def index
    @logs = current_user.logs
  end

  # GET /logs/1 or /logs/1.json
  def show; end

  # GET /logs/new
  def new
    @log = Log.new
  end

  # GET /logs/1/edit
  def edit
    @log
  end

  # POST /logs or /logs.json
  def create
    @log = Log.new(log_params)
    @log.user = current_user
    if @log.save
      redirect_to log_url(@log), notice: 'Log was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logs/1 or /logs/1.json
  def update
    if @log.update(log_params)
      redirect_to log_url(@log), notice: 'Log was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /logs/1 or /logs/1.json
  def destroy
    @log.destroy
    redirect_to logs_url, notice: 'Log was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_log
    @log = Log.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def log_params
    params.require(:log).permit(:user_id, :date, :sleep, :meal, :medicine, :bathe, :go_out, :memo)
  end
end
