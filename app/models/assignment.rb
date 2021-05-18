class Assignment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  after_initialize  :default_values!

  scope :owners, -> { where(case_owner: true) }

  private

  def default_values!
    self.case_owner ||= false
    self.fee        ||= self.user.role.default_fee
  end
end
