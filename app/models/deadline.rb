class Deadline < ApplicationRecord
  include Filtering

  CATEGORIES = %w(internal external court-ordered legal)

  belongs_to :project, optional: true
  belongs_to :user

  validates :label, length: { in: 2..50 }
  validates :category, inclusion: { in: CATEGORIES }
  validates :date, presence: true

  scope :due_immediately, -> { where('date <= ?', Date.tomorrow) }
  scope :due_soon,        -> { where(date: (Date.tomorrow + 1..Date.today + 10)) }
  scope :due_later,       -> { where('date >= ?', Date.today + 11) }

  scope :filter_by_category, -> (str) { where(category: str) }
  scope :filter_by_user,     -> (str) { where(user: str) }
  scope :filter_by_query,    -> (str) { where('label LIKE ?', "%#{str}%") }

  def self.filter_by_urgency(str)
    case str.to_i
    when 0 then send(:due_immediately)
    when 1 then send(:due_soon)
    when 2 then send(:due_later)
    end
  end

  def self.with_urgency(urgency, query = nil)
    filter_by_query(query).filter_by_urgency(urgency).where(completed_at: nil)
  end
end
