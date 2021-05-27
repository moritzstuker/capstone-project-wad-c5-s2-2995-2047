class Assignment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  after_validation :default_values!

  private

  def default_values!
    self.default_fee ||= self.user.fee
  end
end
