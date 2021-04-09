class User < ApplicationRecord
  has_many   :project_users
  has_many   :projects, through: :project_users
  has_many   :projects, inverse_of: 'owner'
  has_many   :time_entries
  belongs_to :contact

  has_secure_password

  before_validation :downcase_login
  after_initialize  :default_values

  private

  def downcase_login
    self.login = login.downcase
  end

  def default_values
    self.role ||= 'associate'
    self.avatar ||= 'jean-beller-8ndbKLm3wCM-unsplash.jpg'
  end
end
