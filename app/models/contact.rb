class Contact < ApplicationRecord
  include Filtering

  CATEGORIES = [
    'natural person',
    'legal person'
  ].freeze

  FORMATS = {
    name:       '#{first_name} #{last_name} #{suffix}',
    short_name: '#{first_name.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{last_name}',
    long_name:  '#{prefix} #{first_name} #{last_name} #{suffix}',
    full_name:  '#{prefix} #{first_name} #{last_name} #{suffix}<span class=\"mute\"> (#{combine(:category)})</span>',
    initials:   '#{first_name.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{last_name.to_s.chars.first}.',
    address:    '#{address[:pobox]}<br>#{address[:street]}&nbsp;#{address[:streetno]}<br>#{address[:zip]}&nbsp;#{address[:city]}<br>#{address[:country]}',
    city:       '#{address[:zip]} #{address[:city]} (#{address[:country]})',
    street:     '#{address[:street]} #{address[:streetno]}',
    category:   '#{category == \'natural person\' ? \'Private person\' : \'Company\'}',
    role:       '#{role.titleize}'
  }

  belongs_to :role, class_name: "ContactRole", foreign_key: "contact_role_id"
  has_one    :user
  belongs_to              :address, class_name: "ContactAddress", foreign_key: "contact_address_id"
  has_and_belongs_to_many :projects

  scope :search,              -> (str) { where('first_name LIKE ? OR last_name LIKE ? OR suffix LIKE ?', "%#{str}%", "%#{str}%", "%#{str}%") }

  scope :get_role,    -> (str) { includes(:role).where("contact_roles.label = '#{str}'").references(:contact_roles).order('last_name') }
  scope :clients,     ->       { get_role('client') }
  scope :adversaries, ->       { get_role('adversary') }
  scope :employees,   ->       { get_role('employee') }
  scope :other,       ->       { get_role('other') }

  scope :filter_by_role, -> (str) { where(role: str) }
  scope :filter_by_category, -> (str) { where(category: str) }

  after_initialize  :default_values!
  before_validation { self.email = email.downcase }

  validates :first_name, length: { maximum: 60 }
  validates :last_name,  presence: true, length: { maximum: 60 }
  validates :email,      presence: true, length: { minimum: 6, maximum: 60 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  def combine(format = :name)
    eval('"' + FORMATS[format.to_sym] + '"').gsub(/^\s*(?:<br\s*\/?\s*>)+|(?:<br\s*\/?\s*>)+\s*$/i, "").gsub(/\s+/, " ").strip.html_safe
  end

  private

  def default_values!
    # nothing for now...
  end
end
