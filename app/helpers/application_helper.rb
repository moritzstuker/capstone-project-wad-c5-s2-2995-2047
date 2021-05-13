module ApplicationHelper
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if logged_in?
  end

  def icon_tag(str)
    doc = File.open("app/assets/images/octicons/#{str}.svg", 'r') { |f| Nokogiri::XML(f) }
    icon = doc.at_css('svg')
    icon['class'] = "icon #{str}"
    raw icon
  end
end
