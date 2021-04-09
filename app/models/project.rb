class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :project_users
  has_many :users, through: :project_users
  has_many :time_entries

  validates_presence_of :name
  validates_uniqueness_of :name
end
