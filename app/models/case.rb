class Case < ApplicationRecord
  has_many :users

  validates_presence_of :name, :description
  validates_uniqueness_of :name
end
