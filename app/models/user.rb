class User < ApplicationRecord
  has_and_belongs_to_many :projects

  has_secure_password

  validates :username, uniqueness: true
  validates :role,  inclusion: { in: %w(client associate partner admin) }

  after_initialize  :defaults
  before_validation :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end

  def defaults
    self.role ||= 'client'
    self.avatar ||= 'jean-beller-8ndbKLm3wCM-unsplash.jpg'
  end
end
