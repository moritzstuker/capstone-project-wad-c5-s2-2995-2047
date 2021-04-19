class User < ApplicationRecord
  ROLES = %w(admin partner associate intern).freeze

  belongs_to :contact, optional: true

  has_secure_password

  after_initialize  :default_values!
  before_validation { self.login = login.downcase }

  validates :login,    presence: true, length: { minimum: 2, maximum: 30 }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :role,     inclusion: { in: User::ROLES }
  # validates :contact

  private

  def default_values!
    self.avatar ||= 'avatar.svg'
    self.role   ||= User::ROLES.last
  end
end
