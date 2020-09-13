class UsersController < ApplicationController
  skip_before_action :redirect_if_logged_out, only: [:new, :create]

  def new
    @user = User.new
end

  def show
    @user = find_user
    if @user.nil?
      flash.alert = 'No user found with this id'
      redirect_to root_path
    end
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
    params.require(:user).permit(:name, :password, :email)
  end

  def find_user
    @user = User.find_by(id:params[:id])
  end
end
