class SessionsController < ApplicationController
  skip_before_action :redirect_if_logged_out, raise: false
  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @error = 'Incorrect username and/or password'
      render :new
    end
  end

    def google_auth
    u = User.find_or_create_with_oauth(auth)
    session[:user_id] = u.id

    redirect_to '/movies'
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
