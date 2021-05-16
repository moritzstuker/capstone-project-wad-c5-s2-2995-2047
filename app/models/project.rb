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
  has_many   :activities
  has_many   :deadlines
  has_many   :parties
  has_many   :contacts, through: "Parties"

  scope :search, -> (str) { joins(:parties).where("label LIKE :query OR reference LIKE :query OR contacts.first_name LIKE :query OR contacts.last_name LIKE :query", query: "%#{str}%").uniq }

  def name_based_on_parties
    str = ""

    if parties.clients.exists?
      str += parties.clients.first.combine(:name)
      str += " et al." if parties.clients.count > 1
    end

    str += "<span class=\"mute\">&nbsp;v.&nbsp;</span>" if parties.clients.exists? && parties.adversaries.exists?

    if parties.adversaries.exists?
      str += parties.adversaries.first.combine(:name)
      str += " et al." if parties.adversaries.count > 1
    end

    return str.html_safe
  end

  def combine(format = :name)
    eval('"' + FORMATS[:string][format] + '"').gsub(/^\s*(?:<br\s*\/?\s*>)+|(?:<br\s*\/?\s*>)+\s*$/i, "").gsub(/\s+/, " ").strip.html_safe
  end
end
