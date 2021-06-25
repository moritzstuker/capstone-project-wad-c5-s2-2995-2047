class ContactRole < ApplicationRecord
  ROLES = {
    'client':    '#347d39', # green
    'adversary': '#c93c37', # red
    'other':     '#f69d50'  # yellow
  }

  has_many :contacts

  def friendly_name
    "#{ label.capitalize }"
  end
end
