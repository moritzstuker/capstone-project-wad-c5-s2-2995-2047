class Deadline < ApplicationRecord
  include Filtering

  CATEGORIES = ["internal", "external", "court-ordered", "legal"].freeze

  belongs_to :project
  belongs_to :assignee, class_name: "User"

  scope :search, -> (str) { where('label LIKE ?', "%#{str}%") }

  scope :filter_by_category, -> (str) { where(category: str) }
  scope :filter_by_show,   -> (str) {
    if str == 'active'
      where(completed_at: nil)
    elsif str == 'inactive'
      where.not(completed_at: nil)
    end
  }
  scope :filter_by_urgency,  -> (str) { where(date: dates_by_urgency(str)) }
  scope :filter_by_user,     -> (str) { where(assignee: str) }
  
  private

  def self.dates_by_urgency(str)
    dates = Deadline.where(completed_at: nil).distinct.pluck(:date).sort
    case
    when str == '0' && dates.count >= 2 then dates[0..1]
    when str == '1' && dates.count >= 4 then dates[2..3]
    when str == '2' && dates.count >= 5 then dates[4..-1]
    else dates
    end
  end
end
