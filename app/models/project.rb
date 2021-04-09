class Project < ApplicationRecord
  #has_many :project_members
  #has_many :users, through: :project_members
  has_many :project_roles
  has_many :users, through: :project_roles
  #has_one  :project_owner
  #has_many :owners,  class_name: "User", through: :project_owner

  validates_presence_of :name
  validates_uniqueness_of :name
end
