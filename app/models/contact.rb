class Contact < ApplicationRecord
  has_one :user

  def name
    if firstname.present? && lastname.present?
      "#{firstname} #{lastname}"
    else
      firstname.to_s || lastname.to_s
    end
  end
end
