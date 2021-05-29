class Project < ApplicationRecord

  STATUS = [
    'active',
    'inactive'
  ].freeze

  FORMATS = {
    heading:   'cases<span class=\"mute\">&nbsp;&sol;&nbsp;</span>#{build_project_name}',
    name:      '#{build_project_name}',
    long_name: '#{build_project_name}<span class=\"mute\"><span class=\"no-calt\">:</span>&nbsp;</span>#{label}',
  }

  has_many                :activities
  has_and_belongs_to_many :adversaries, -> { adversaries }, class_name: "Contact"
  has_many                :assignments
  has_many                :assignees, -> { lawyers }, through: :assignments, source: :user
  belongs_to              :category, class_name: "ProjectCategory", foreign_key: "project_category_id", optional: true
  has_and_belongs_to_many :clients, -> { clients }, class_name: "Contact"
  has_many                :deadlines
  belongs_to              :owner, class_name: "User"

  scope :label_contains,     -> (str) { where('label LIKE ?', "%#{str}%") }
  scope :reference_contains, -> (str) { where('reference LIKE ?', "%#{str}%") }
  scope :search,             -> (str) { label_contains(str).or(reference_contains(str)) }

  validates :label,    presence: true

  def combine(format = :name)
    if label.nil?
      build_project_name
    else
      eval('"' + FORMATS[format.to_sym] + '"').gsub(/^\s*(?:<br\s*\/?\s*>)+|(?:<br\s*\/?\s*>)+\s*$/i, "").gsub(/\s+/, " ").strip.html_safe
    end
  end

  private

  def build_project_name
    str  = ""
    str += clients.first.combine(:name) if clients.exists?
    str += "&nbsp;<span class=\"mute\">et al.</span>" if clients.count > 1
    str += "<span class=\"mute\">&nbsp;v.&nbsp;</span>" if clients.exists? && adversaries.exists?
    str += adversaries.first.combine(:name) if adversaries.exists?
    str += "&nbsp;<span class=\"mute\">et al.</span>" if adversaries.count > 1
    str.html_safe
  end
end
