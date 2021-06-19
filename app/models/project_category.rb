class ProjectCategory < ApplicationRecord
  CATEGORIES = {
    'bankruptcy law':        '#22272e', # dark grey
    'civil law':             '#4184e4', # blue
    'corporate law':         '#143d79', # dark blue
    'criminal law':          '#922323', # red
    'data protection':       '#545d68', # light grey
    'immigration law':       '#347d39', # green
    'intellectual property': '#ae7c14', # yellow
    'labor law':             '#ae5622'  # orange
  }

  has_many :projects

  def friendly_name
    "#{ label.capitalize }"
  end
end
