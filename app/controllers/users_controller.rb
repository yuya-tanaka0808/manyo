class UsersController < ApplicationController
  before_action :find_user, only:[:show, :edit, :update]
  before_action :current_user

  def new
    login_checker
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
    user_checker
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
