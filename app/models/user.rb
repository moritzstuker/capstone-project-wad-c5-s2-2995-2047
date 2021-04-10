class User < ApplicationRecord
  has_many   :project_users
  has_many   :projects, through: :project_users
  has_many   :projects, inverse_of: 'owner'
  has_many   :time_entries
  belongs_to :contact, optional: true
  
  accepts_nested_attributes_for :contact

  has_secure_password

  validates :login, presence: true, length: { minimum: 6, maximum: 60 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  before_validation { self.login = login.downcase }
  after_initialize  :default_values

  private

  def default_values
    self.avatar ||= 'jean-beller-8ndbKLm3wCM-unsplash.jpg'
  end
end
