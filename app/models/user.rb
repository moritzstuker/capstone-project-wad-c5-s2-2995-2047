class User < ApplicationRecord

  ROLES = %w(admin partner associate intern).freeze

  belongs_to :contact, optional: true

  has_secure_password

  after_initialize  :default_values!
  before_validation { self.login = login.downcase }

  validates :login,           presence: true, length: { minimum: 2, maximum: 30 }, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 6 }
  validates :role,            inclusion: { in: ROLES }
  # validates :contact HAS TO BE UNIQUE

  private

  def default_values!
    self.avatar ||= 'avatar.svg'
    self.role   ||= ROLES.last
  end
end
