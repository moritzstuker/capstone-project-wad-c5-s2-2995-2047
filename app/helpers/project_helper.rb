module ProjectHelper
  def bg_color(str)
    case str
    when "client" then "green-bg"
    when "adversary" then "red-bg"
    when "employee" then "blue-bg"
    when "other" then "yellow-bg"
    end
  end

  def fee (int)
    "#{number_to_currency(int, unit: "fr.", separator: ".", delimiter: "'", format: "%n %u")}".html_safe
  end
end
