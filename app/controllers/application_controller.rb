class ApplicationController < ActionController::Base
  before_action :require_login # since most pages are restricted, sets a login requirement by default, with exceptions (ie login and home pages)
  helper_method :current_user, :is_current_user?, :is_admin?, :is_partner?, :is_associate?, :is_intern?, :is_logged_in?
  protect_from_forgery with: :exception

  private

  def error_message_for(record, field)
    record.full_messages_for(field).join(",")
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if is_logged_in?
  end

  def is_current_user?(user)
    user == current_user
  end

  def user_role(user)
    user.role.label if is_logged_in?
  end

  def is_admin?(user)
    user_role(user) == 'admin'
  end

  def is_partner?(user)
    user_role(user) == 'partner'
  end

  def is_associate?(user)
    user_role(user) == 'associate'
  end

  def is_intern?(user)
    user_role(user) == 'intern'
  end

  def is_logged_in?
    !!session[:user_id]
  end

  def require_login
    unless is_logged_in?
      session[:forwarding_url] = request.original_url if request.get?
      redirect_to login_url, alert: "Please log in."
    end
  end
end
