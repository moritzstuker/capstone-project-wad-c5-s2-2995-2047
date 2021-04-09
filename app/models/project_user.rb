class ProjectUser < ApplicationRecord
  belongs_to :user
  belongs_to :project

  after_initialize :default_values

  private

  def default_values
    self.fee ||= 300
    self.role ||= 'member'
  end
end
