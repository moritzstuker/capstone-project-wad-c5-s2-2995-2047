class Assignment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  before_validation :set_owner
  after_validation :default_values!

  scope :owners, -> { where(case_owner: true) }
  scope :ordered, -> { includes(user: :contact).order('case_owner DESC', 'contacts.last_name DESC') }

  private

  def set_owner
    self.case_owner = (self.user.role.label == 'partner') ? true : false
  end

  def default_values!
    self.fee ||= self.user.role.default_fee
  end
end
