class SessionsController < ApplicationController
  skip_before_action :redirect_if_logged_out, raise: false
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      @error = 'Incorrect username and/or password'
      render :new
    end
  end

    def destroy
    session.clear
    redirect_to root_path
  end

  
end
