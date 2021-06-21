class ContactRole < ApplicationRecord
  ROLES = {
    'client':    '#347d39', # green
    'adversary': '#ad2e2c', # red
    'other':     '#daaa3f'  # yellow
  }

  has_many :contacts

  def friendly_name
    "#{ label.capitalize }"
  end
end
