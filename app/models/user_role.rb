class UserRole < ApplicationRecord
  DEFAULTS = {
    'admin': {
      'fee': 0,
      'access_level': 0
    },
    'partner': {
      'fee': 400,
      'access_level': 1
    },
    'associate': {
      'fee': 350,
      'access_level': 2
    },
    'intern': {
      'fee': 180,
      'access_level': 3
    }
  }.freeze

  has_many :users
end
