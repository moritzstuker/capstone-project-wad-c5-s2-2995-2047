class User < ApplicationRecord
  belongs_to :contact
  belongs_to :role, class_name: "UserRole", foreign_key: "user_role_id"
  has_many :activities
  has_many :assignments
  has_many :projects, through: :assignments

  has_secure_password

  after_initialize  :default_values!
  before_validation { self.login = login.downcase }

  validates :login,           presence: true, length: { minimum: 2, maximum: 30 }, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 6 }
  # validates :access_level,    presence: true
  # validates :contact HAS TO BE UNIQUE

  private

  def default_values!
    self.avatar         ||= 'avatar.svg'
    #self.access_level   ||= ROLES.last
  end
end
