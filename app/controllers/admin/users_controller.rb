class Admin::UsersController < ApplicationController
  before_action :current_user
  before_action :if_not_admin, only: [:index, :new,:create, :show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    # @users = User.select(:name, :id)
    # @tasks = Task.includes(:user)
    @users = User.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @tasks = Task.where(user_id: @user.id)
  end

  def edit
  end

  def update
    puts @user
    if @user.update(user_params)
      redirect_to admin_user_path
    else
      flash[:notice] = t('view.models.admin.administrator_users_cannot_be_edited')
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: t('view.models.admin.destroy')
    else
      redirect_to admin_users_path, notice: t('view.models.admin.administrator_users_cannot_be_deleted')
    end
  end

  private
  def if_not_admin
    unless current_user.admin?
      flash[:notice] = "管理者以外アクセスできません！"
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
