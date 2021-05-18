class Project < ApplicationRecord

  STATUS = [
    'active',
    'inactive'
  ].freeze

  FORMATS = {
    string: {
      name:                '#{build_project_name}',
      long_name:           '#{build_project_name}<span class=\"mute\"> (#{label})</span>',
      long_name_two_lines: '#{build_project_name}<br /><span class=\"mute\">(#{label})</span>',
    }
  }

  belongs_to :category, class_name: "ProjectCategory", foreign_key: "project_category_id", optional: true
  has_many   :activities
  has_many   :deadlines
  has_many   :assignments
  has_many   :assignees, through: :assignments, source: :user
  has_one    :owner, -> { owners }, class_name: "Assignment"
  has_and_belongs_to_many :adversaries, -> { adversaries }, class_name: "Contact"
  has_and_belongs_to_many :clients,     -> { clients },     class_name: "Contact"

  def combine(format = :name)
    if label.nil?
      build_project_name
    else
      eval('"' + FORMATS[:string][format] + '"').gsub(/^\s*(?:<br\s*\/?\s*>)+|(?:<br\s*\/?\s*>)+\s*$/i, "").gsub(/\s+/, " ").strip.html_safe
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
