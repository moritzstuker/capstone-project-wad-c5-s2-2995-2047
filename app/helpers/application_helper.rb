module ApplicationHelper
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if logged_in?
  end

  def active_page?(path)
    " is-active" if request.path == path
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "ffa caret-#{sort_direction}" : "ffa caret"
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :dir => direction, :search => params[:search], :personality => params[:personality]}, {:class => css_class}
  end
end
