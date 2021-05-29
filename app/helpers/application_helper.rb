module ApplicationHelper
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if logged_in?
  end

  def sidebar_text (str, sym)
    raw "<span>#{ str }</span><span class=\"counter\">#{ page_items(sym.to_s.classify) }</span>"
  end
end
