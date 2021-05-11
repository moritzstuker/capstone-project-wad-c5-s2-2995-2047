module ContactHelper
  def bg_color(str)
    case str
    when "client" then "green-bg"
    when "adversary" then "red-bg"
    when "employee" then "blue-bg"
    when "other" then "yellow-bg"
    end
  end
end
