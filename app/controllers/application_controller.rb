class ApplicationController < ActionController::Base
  before_action :require_login # since most pages are restricted, sets a login requirement by default, with exceptions (ie login and home pages)

  helper_method :current_user, :is_current_user?, :is_logged_in?, :is_admin?, :is_partner?, :is_associate?, :is_intern?

  protect_from_forgery with: :exception

  around_action :switch_locale

  # uncomment to add locale to param
  # def default_url_options
  #   { locale: I18n.locale }
  # end

  private

  def switch_locale(&action)
    locale = current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def error_message_for(record, field)
    record.full_messages_for(field).join(",")
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if is_logged_in?
  end

  def is_current_user?(user = current_user)
    user == current_user
  end

  def is_logged_in?
    !!session[:user_id]
  end

  def user_role(user = current_user)
    user.role if is_logged_in?
  end

  def is_admin?(user = current_user)
    user_role(user) == 'admin'
  end

  def is_partner?(user = current_user)
    user_role(user) == 'partner'
  end

  def is_associate?(user = current_user)
    user_role(user) == 'associate'
  end

  def is_intern?(user = current_user)
    user_role(user) == 'intern'
  end

  def require_login
    unless is_logged_in?
      session[:forwarding_url] = request.original_url if request.get?
      redirect_to login_url, alert: "#{ t('users.please_log_in') }."
    end
  end
end
