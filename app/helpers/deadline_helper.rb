module DeadlineHelper
  def urgency_by_date(date)
    if Deadline.dates_by_urgency('0').include?(date.to_date)
      ' red'
    elsif Deadline.dates_by_urgency('1').include?(date.to_date)
      ' orange'
    else
      ' green'
    end
  end
end
