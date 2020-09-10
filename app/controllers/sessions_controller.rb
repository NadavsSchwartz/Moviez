class SessionsController < ApplicationController
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
end
