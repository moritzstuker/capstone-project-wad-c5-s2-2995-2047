class Project < ApplicationRecord

  STATUS = %w(active inactive).freeze
  FORMATS = {
    string: {
      name:                '#{name_based_on_parties}',
      long_name:           '#{name_based_on_parties}<span class=\"mute\"> (#{label})</span>',
      long_name_two_lines: '#{name_based_on_parties}<br /><span class=\"mute\">(#{label})</span>',
    }
  }

  belongs_to :category, class_name: "ProjectCategory", foreign_key: "project_category_id", optional: true
  has_and_belongs_to_many :parties, class_name: "Contact"
  has_many :activities
  has_many :deadlines

  def render_project_parties(str)
    arr = parties.where(role: str)
    "#{arr.first.combine(:name)}#{' et al.' if arr.count > 1}"
  end

  def name_based_on_parties
    str = "#{render_project_parties('client')}"
    if parties.where(role: 'adversary').count > 1
      str += "<span class=\"mute\">&nbsp;v.&nbsp;</span>#{render_project_parties('adversary')}"
    end
    str
  end

  def combine(format = :name)
    eval('"' + FORMATS[:string][format] + '"').gsub(/^\s*(?:<br\s*\/?\s*>)+|(?:<br\s*\/?\s*>)+\s*$/i, "").gsub(/\s+/, " ").strip.html_safe
  end
end
