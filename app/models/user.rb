class User < ApplicationRecord
  belongs_to :contact
  belongs_to :role, class_name: "UserRole", foreign_key: "user_role_id"
  has_many :activities
  has_many :assignments
  has_many :deadlines
  has_many :projects, through: :assignments, source: :assignee
  has_many :projects, inverse_of: :owner

  accepts_nested_attributes_for :contact

  has_secure_password

  scope :get_role,   -> (str) { includes(:role).where("user_roles.label = '#{str}'").references(:user_roles) }
  scope :admins,     ->       { get_role('admin') }
  scope :partners,   ->       { get_role('partner') }
  scope :associates, ->       { get_role('associate') }
  scope :interns,    ->       { get_role('intern') }
  scope :lawyers,    ->       { includes(:role).where("user_roles.label != 'admin'").references(:user_roles) }

  before_create  :default_values!
  before_validation { self.login = login.downcase }

  validates :login,    presence: true, length: { minimum: 2, maximum: 30 }, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 6 }
  # validates :access_level,    presence: true
  # validates :contact HAS TO BE UNIQUE
  
  def fee
    role.default_fee
  end

  private

  def default_values!
    self.preferred_lang ||= 'en'
    self.avatar         ||= 'fallback_avatars/1.jpg'
    self.role           ||= UserRoles.last
  end
end
