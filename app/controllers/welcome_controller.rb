class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
  end

  def update
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
