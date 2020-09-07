class ApplicationController < ActionController::Base
  before_action :basic, if: :production?
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user
   # 現在ログイン中のユーザが存在しない場合、ログインページにリダイレクトさせる。
    if @current_user == nil
      flash[:notice] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end

  private
  def production?
    Rails.env.production?
  end

  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
