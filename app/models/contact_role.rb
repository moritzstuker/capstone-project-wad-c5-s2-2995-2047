class ContactRole < ApplicationRecord
  DEFAULTS = {
    'client':    '#347d39', # green
    'adversary': '#ad2e2c', # red
    'other':     '#daaa3f', # yellow
    'employee':  '#4184e4', # blue
  }

  has_many :contacts
end
