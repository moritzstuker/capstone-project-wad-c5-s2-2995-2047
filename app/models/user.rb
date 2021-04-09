class User < ApplicationRecord
  has_many   :project_users
  has_many   :projects, through: :project_users
  has_many   :projects, inverse_of: 'owner'
  has_many   :time_entries
  belongs_to :contact

  has_secure_password

  validates_format_of     :login, :with => /\A[a-z0-9_\-@\.]*\z/i
  validates_length_of     :login, :maximum => 60
  validates_length_of     :firstname, :lastname, :maximum => 30
  validates_presence_of   :login, :firstname, :lastname
  validates_uniqueness_of :login, :case_sensitive => false

  before_validation :downcase_login
  after_initialize  :default_values

  def name
    "#{firstname} #{lastname}"
  end

  private

  def downcase_login
    self.login = login.downcase
  end

  def default_values
    self.role ||= 'client'
    self.avatar ||= 'jean-beller-8ndbKLm3wCM-unsplash.jpg'
  end
end
