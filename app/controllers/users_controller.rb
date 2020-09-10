class UsersController < ApplicationController
    def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_data)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

    private
  def user_data
    params.require(:user).permit(:rname, :password, :email)
  end
end
