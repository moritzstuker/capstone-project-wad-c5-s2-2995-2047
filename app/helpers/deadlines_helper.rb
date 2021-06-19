module DeadlinesHelper
  def color_by_urgency(str = nil)
    case str
    when '0' then '#c93c37'
    when '1' then '#f69d50'
    else '#347d39'
    end
  end

  def get_urgency_of_date(date)
    case true
    when date <= Date.tomorrow then '0'
    when date.between?(Date.tomorrow + 1, Date.today + 10) then '1'
    when date >= Date.today + 11 then '2'
    else nil
    end
  end
end
