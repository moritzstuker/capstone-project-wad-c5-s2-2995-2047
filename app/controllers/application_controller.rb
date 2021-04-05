class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :info, :success, :danger

  def current_user
    if @current_user.present?
      return @current_user
    end
    @current_user = User.find(session[:user_id])
  end

  def logged_in?
    session[:user_id].present?
  end

  def authenticated?
    redirect_to login_path unless logged_in?
  end
end
