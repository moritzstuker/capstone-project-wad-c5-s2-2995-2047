class Contact < ApplicationRecord
  has_one :user

  validates :email, presence: true, length: { minimum: 6, maximum: 60 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :firstname, length: { maximum: 30 }
  validates :lastname, presence: true, length: { maximum: 30 }

  def name
    if firstname.present?
      "#{firstname} #{lastname}"
    else
      "#{lastname}"
    end
  end
end
