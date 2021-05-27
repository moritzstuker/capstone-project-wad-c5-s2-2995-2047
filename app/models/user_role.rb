class UserRole < ApplicationRecord
  DEFAULTS = {
    'admin': {
      'default_fee': 0,
      'access_level': 0
    },
    'partner': {
      'default_fee': 400,
      'access_level': 1
    },
    'associate': {
      'default_fee': 350,
      'access_level': 2
    },
    'intern': {
      'default_fee': 180,
      'access_level': 3
    }
  }.freeze

  has_many :users
end
