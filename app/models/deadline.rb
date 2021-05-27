class Deadline < ApplicationRecord

  CATEGORIES = ["internal", "external", "court-ordered", "legal"].freeze

  belongs_to :project
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id"

  scope :label_contains, -> (str) { where('label LIKE ?', "%#{str}%") }
  scope :search,              -> (str) { label_contains(str) }

end
