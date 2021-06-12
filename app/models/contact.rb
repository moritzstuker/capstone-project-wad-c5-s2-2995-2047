class Contact < ApplicationRecord
  include Filtering

  FORMATS = {
    name:      '[obj.first_name, obj.last_name, " "]',
    full_name: '[obj.prefix, obj.first_name, obj.last_name, " "]',
    address:   '[obj.address.pobox, "#{obj.address.street} #{obj.address.streetno}", "#{obj.address.zip} #{obj.address.city}", obj.address.country, "\n"]',
    category:  '"#{obj.company ? "Company" : "Private person"}"'
  }

  belongs_to              :role, class_name: "ContactRole", foreign_key: "contact_role_id"
  belongs_to              :address, class_name: "ContactAddress", foreign_key: "contact_address_id"
  has_one                 :user
  has_and_belongs_to_many :projects

  accepts_nested_attributes_for :address

  scope :search_in_contact_first_name, -> (str) { where('first_name LIKE ?', "%#{str}%") }
  scope :search_in_contact_last_name,  -> (str) { where('last_name LIKE ?', "%#{str}%") }

  scope :search_in_address_street,  -> (str) { includes(:address).where('contact_addresses.street LIKE ?', "%#{str}%") }
  scope :search_in_address_zip,     -> (str) { includes(:address).where('contact_addresses.zip LIKE ?', "%#{str}%") }
  scope :search_in_address_city,    -> (str) { includes(:address).where('contact_addresses.city LIKE ?', "%#{str}%") }
  scope :search_in_address_country, -> (str) { includes(:address).where('contact_addresses.country LIKE ?', "%#{str}%") }

  scope :search, -> (str) {
     search_in_contact_first_name(str)
    .or(search_in_contact_last_name(str))
    .includes(:address)
    .or(search_in_address_street(str))
    .or(search_in_address_zip(str))
    .or(search_in_address_city(str))
    .or(search_in_address_country(str))
    .references(:contact_addresses)
  }

  scope :get_role,    -> (str) { includes(:role).where("contact_roles.label = '#{str}'").references(:contact_roles) }
  scope :clients,     ->       { get_role('client') }
  scope :adversaries, ->       { get_role('adversary') }
  scope :employees,   ->       { get_role('employee') }
  scope :other,       ->       { get_role('other') }

  scope :filter_by_role,     -> (str) { where(role: str) }
  scope :filter_by_country,  -> (str) { includes(:address).where("lower(contact_addresses.country) = ?", str).references(:contact_addresses) }

  validates :first_name, length: { maximum: 15 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  validates :email,      presence: true, length: { minimum: 6, maximum: 60 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true

  after_validation :default_values!

  def self.filter_by_category(str)
    if str == '1'
      where(company: true)
    elsif str == '0'
      where(company: false)
    end
  end

  private

  def default_values!
    self.company ||= false
  end
end
