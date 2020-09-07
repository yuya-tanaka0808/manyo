class UsersController < ApplicationController
  before_action :find_user, only:[:show]
  before_action :current_user
  before_action :user_checker

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_checker
    if current_user.id != @user.id
      flash[:notice] =  "権限がありません"
      redirect_to tasks_path
    end
  end

end
