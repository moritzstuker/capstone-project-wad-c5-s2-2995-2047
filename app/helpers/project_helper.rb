module ProjectHelper
  def fee (int)
    "#{number_to_currency(int, unit: "fr.", separator: ".", delimiter: "'", format: "%n %u")}".html_safe
  end
end
