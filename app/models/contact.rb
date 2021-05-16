class Contact < ApplicationRecord

  PERSONALITIES = ["natural person", "legal person"].freeze
  FORMATS = {
    string: {
      name:       '#{first_name} #{last_name}',
      short_name: '#{first_name.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{last_name}',
      long_name:  '#{prefix} #{first_name} #{last_name} #{suffix}',
      full_name:  '#{prefix} #{first_name} #{last_name} #{suffix}<span class=\"mute\"> (#{combine(:category)})</span>',
      initials:   '#{first_name.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{last_name.to_s.chars.first}.',
      address:    '#{address[:pobox]}<br>#{address[:street]}&nbsp;#{address[:streetno]}<br>#{address[:zip]}&nbsp;#{address[:city]}<br>#{address[:country]}',
      city:       '#{address[:zip]} #{address[:city]} (#{address[:country]})',
      street:     '#{address[:street]} #{address[:streetno]}',
      category:   '#{category == \'natural person\' ? \'Private person\' : \'Company\'}',
      role:       '#{role.titleize}'
    },
    order: {
      name: %w(last_name first_name id),
      city: %w(address[:city] address[:zip] address[:country] id),
      role: %w(role created_at)
    }
  }

  has_one    :user
  belongs_to :role, class_name: "ContactRole", foreign_key: "contact_role_id"
  has_many   :parties
  has_many   :projects, through: "parties"

  scope :first_name_contains, -> (str) { where('first_name LIKE ?', "%#{str}%") }
  scope :last_name_contains,  -> (str) { where('last_name LIKE ?', "%#{str}%") }
  scope :address_contains,    -> (str) { where('address LIKE ?', "%#{str}%") }
  scope :search,              -> (str) { first_name_contains(str).or(last_name_contains(str)).or(address_contains(str)) }

  scope :get_role,    -> (str) { includes(:role).where("contact_roles.label = '#{str}'").references(:contact_roles) }
  scope :clients,     ->       { get_role('client') }
  scope :adversaries, ->       { get_role('adversary') }
  scope :employees,   ->       { get_role('employee') }
  scope :other,       ->       { get_role('other') }


  after_initialize  :default_values!
  before_validation { self.email = email.downcase }

  validates :first_name, length: { maximum: 60 }
  validates :last_name,  presence: true, length: { maximum: 60 }
  validates :email,      presence: true, length: { minimum: 6, maximum: 60 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  #validates :role,       presence: true

  serialize :address, Hash

  def combine(format = :name)
    eval('"' + FORMATS[:string][format] + '"').gsub(/^\s*(?:<br\s*\/?\s*>)+|(?:<br\s*\/?\s*>)+\s*$/i, "").gsub(/\s+/, " ").strip.html_safe
  end

  private

  def default_values!
    # nothing for the time being...
  end
end
