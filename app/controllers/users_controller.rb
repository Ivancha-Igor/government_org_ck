class UsersController < ApplicationController
  before_action :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to :back, notice: 'Нужно заполнить Email и Пароль, не менее 6 символов'
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
