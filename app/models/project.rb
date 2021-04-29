class Project < ApplicationRecord
  belongs_to :category, class_name: "ProjectCategory", foreign_key: "project_category_id", optional: true
  has_and_belongs_to_many :parties, class_name: "Contact"

  def render_project_parties(str)
    arr = parties.where(role: str)
    "#{arr.first.combine(:name)}#{' et al.' if arr.count > 1}"
  end

  def name_based_on_parties
    "#{render_project_parties('client')}#{' v ' + render_project_parties('adversary') if parties.where(role: 'adversary').count > 1}"
  end
end
