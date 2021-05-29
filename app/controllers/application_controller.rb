class ApplicationController < ActionController::Base
  include SessionHelper
  helper_method :dynamic_search_path

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

  def dynamic_search_path
    eval("#{SIDEBAR_PAGES.key?(controller_name.to_sym) ? controller_name : SIDEBAR_PAGES.keys[0]}_path")
  end

  private

  def restricted_access (int)
    unless logged_in?
      keep_path
      flash[:orange] = "Please log in."
      redirect_to login_url
    end
  end

  def restrict_access (int)
    unless current_user.role.access_level <= int
      flash[:red] = "Access denied."
      redirect_to projects_path
    end
  end
end
