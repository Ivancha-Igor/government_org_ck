class UsersController < ApplicationController
  before_action :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      if Rails.env.production?
        UserMailer.delay.welcome_email(@user)
      else
        UserMailer.welcome_email(@user).deliver_now
      end
      redirect_to root_path
    else
      redirect_to :back, notice: t('messages.user_back')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
