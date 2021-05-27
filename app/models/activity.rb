class Activity < ApplicationRecord

  CATEGORIES = [
    "Email/Letter",
    "Meeting",
    "Phone call",
    "Court hearing"
  ].freeze

  belongs_to :project
  belongs_to :user

  before_validation { self.fee ||= 0 }
end
