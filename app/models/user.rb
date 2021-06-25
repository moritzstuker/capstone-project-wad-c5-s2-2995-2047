class User < ApplicationRecord
  enum role: {
    intern: 0,
    associate: 1,
    partner: 2,
    admin: 3
  }

  has_many   :projects, foreign_key: :owner_id, class_name: 'Project', dependent: :destroy
  has_many   :activities
  has_many   :deadlines

  validates :login, presence: true, length: { in: 2..50 }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { in: 2..100 }
#  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true, length: { in: 2..75 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :locale, inclusion: { in: proc { I18n.available_locales.map(&:to_s) } }

  scope :get_role,   -> (str) { where(role: str) }
  scope :admins,     ->       { get_role(3) }
  scope :partners,   ->       { get_role(2) }
  scope :associates, ->       { get_role(1) }
  scope :interns,    ->       { get_role(0) }
  scope :lawyers,    ->       { where.not(role: 3) }

  after_initialize :set_defaults
  before_validation { self.login = login.downcase }

  has_secure_password

  def friendly_name
    "#{ name } (#{ role.capitalize })"
  end

  private

  def set_defaults
    if self.new_record?
      self.default_fee ||= 300.00
      self.avatar      ||= 'fallback_avatars/1.jpg'
      self.role        ||= :intern
    end
  end
end
