class Project < ApplicationRecord
  belongs_to :category, class_name: "ProjectCategory", foreign_key: "project_category_id", optional: true
  has_and_belongs_to_many :parties, class_name: "Contact"
end
