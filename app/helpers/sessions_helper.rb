module SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def user_checker
    if current_user != @user
      flash[:notice] =  "権限がありません"
      redirect_to tasks_path
    end
  end

end
