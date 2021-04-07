class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true

  has_and_belongs_to_many :cases
end
