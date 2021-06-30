class Activity < ApplicationRecord
  CATEGORIES = %w(Email/Letter Meeting Phone\ call Court\ hearing)

  belongs_to :project
  belongs_to :user

  after_initialize :set_defaults

  private

  def set_defaults
    if self.new_record?
      self.date ||= Date.today
    end
  end
end
