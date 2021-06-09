class Activity < ApplicationRecord

  CATEGORIES = [
    "Email/Letter",
    "Meeting",
    "Phone call",
    "Court hearing"
  ].freeze

  belongs_to :project
  belongs_to :user

  after_validation :default_values!

  private

  def default_values!
    self.fee ||= 0
    self.date ||= Date.today
  end
end
