class Deadline < ApplicationRecord

  CATEGORIES = ["internal", "external", "court-ordered", "legal"].freeze

  belongs_to :project
end
