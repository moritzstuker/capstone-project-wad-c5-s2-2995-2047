module ProjectHelper
  def fee (int)
    "#{number_to_currency(int, unit: "fr.", separator: ".", delimiter: "'", format: "%n %u")}".html_safe
  end

  def urgency_by_date(date, bool = false)
    if date.to_date == Date.today
      ' red'
    elsif date.to_date == Date.tomorrow
      ' orange'
    elsif date.to_date > Date.tomorrow && bool
      ' green'
    end
  end
end
