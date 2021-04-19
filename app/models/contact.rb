class Contact < ApplicationRecord
  ROLES = %w(client adversary).freeze
  
  has_one :user

  after_initialize  :default_values!
  before_validation { self.email = email.downcase }

  validates :first_name, length: { maximum: 30 }
  validates :last_name,  presence: true, length: { maximum: 30 }
  validates :email,      presence: true, length: { minimum: 6, maximum: 60 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :role,       inclusion: { in: Contact::ROLES }

  serialize :address

  private

  def name
    if first_name.present?
      "#{first_name} #{last_name}"
    else
      "#{last_name}"
    end
  end
end
