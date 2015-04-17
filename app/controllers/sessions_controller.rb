class SessionsController < ApplicationController
  def login
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:warning] = t('messages.session_back')
      redirect_to :back
    end
  end

  def create_session
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end

  def logout
    reset_session
    redirect_to root_path
  end
end
