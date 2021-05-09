class ApplicationController < ActionController::Base
  include SessionHelper

  SIDEBAR_PAGES = {
    projects: 'Cases',
    contacts: 'Contacts',
    deadlines: 'Deadlines'
  }

  protect_from_forgery with: :exception
  add_flash_types :info, :success, :danger
  helper_method :current_user, :logged_in?

  def error_message_for(record, field)
    record.full_messages_for(field).join(",")
  end

  private

  def restricted_access
    unless logged_in?
      restricted_page
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
