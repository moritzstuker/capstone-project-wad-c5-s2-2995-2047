class Contact < ApplicationRecord
  has_one :user

  validates_format_of     :email, :with => URI::MailTo::EMAIL_REGEXP
  validates_length_of     :email, :maximum => 60
  validates_length_of     :firstname, :lastname, :maximum => 30
  validates_presence_of   :email, :lastname
  validates_uniqueness_of :email, :case_sensitive => false

  def name
    if firstname.present? && lastname.present?
      "#{firstname} #{lastname}"
    else
      firstname.to_s || lastname.to_s
    end
  end
end
