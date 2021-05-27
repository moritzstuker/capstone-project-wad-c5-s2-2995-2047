module ProjectHelper
  def fee (int)
    "#{number_to_currency(int, unit: "fr.", separator: ".", delimiter: "'", format: "%n %u")}".html_safe
  end

  def urgency_by_date(date)
    if date.to_date == Date.today
      ' red-bg'
    elsif date.to_date == Date.tomorrow
      ' orange-bg'
    elsif date.to_date > Date.today
      ' green-bg'
    end
  end
end
