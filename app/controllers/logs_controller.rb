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
    @hours_of_sleep = [*0..24]
  end

  # GET /logs/1/edit
  def edit
    @hours_of_sleep = [*0..24]
  end

  # POST /logs or /logs.json
  def create
    @log = Log.new(log_params)
    @log.user = current_user
    if @log.save
      redirect_to log_url(@log), notice: 'Log was successfully created.'
    else
      @hours_of_sleep = [*0..24]
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /logs/1 or /logs/1.json
  def update
    respond_to do |format|
      if @log.update(log_params)
        format.html { redirect_to log_url(@log), notice: 'Log was successfully updated.' }
        format.json { render :show, status: :ok, location: @log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1 or /logs/1.json
  def destroy
    @log.destroy

    respond_to do |format|
      format.html { redirect_to logs_url, notice: 'Log was successfully destroyed.' }
      format.json { head :no_content }
    end
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
