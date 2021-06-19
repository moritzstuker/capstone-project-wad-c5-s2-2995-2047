class Activity < ApplicationRecord
  CATEGORIES = %w(Email/Letter Meeting Phone\ call Court\ hearing)

  belongs_to :project
  belongs_to :user

  validates :label, presence: true, length: { in: 8..72 }
  validates :category, presence: true, inclusion: { in: CATEGORIES, message: "%{value} is not valid" }

  after_initialize :set_defaults

  private

  def set_defaults
    if self.new_record?
      self.fee       ||= current_user.fee
      self.date ||= Date.today
      self.user      ||= current_user
    end
  end
end
