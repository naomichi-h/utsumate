# frozen_string_literal: true

class UsersController < ApplicationController
  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
