class User < ApplicationRecord
  has_many :project_roles
  has_many :projects, through: :project_roles

  has_secure_password

  validates_format_of     :login, :with => /\A[a-z0-9_\-@\.]*\z/i
  validates_length_of     :login, :maximum => 60
  validates_length_of     :firstname, :lastname, :maximum => 30
  validates_presence_of   :login, :firstname, :lastname
  validates_uniqueness_of :login, :case_sensitive => false

  before_validation :downcase_login
  after_initialize  :defaults

  private

  def downcase_login
    self.login = login.downcase
  end

  def defaults
    self.role ||= 'client'
    self.avatar ||= 'jean-beller-8ndbKLm3wCM-unsplash.jpg'
  end
end
