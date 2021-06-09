class Contact < ApplicationRecord
  include Filtering

  belongs_to              :role, class_name: "ContactRole", foreign_key: "contact_role_id"
  belongs_to              :address, class_name: "ContactAddress", foreign_key: "contact_address_id"
  has_one                 :user
  has_and_belongs_to_many :projects

  accepts_nested_attributes_for :address

  scope :search,              -> (str) { where('first_name LIKE ? OR last_name LIKE ? OR suffix LIKE ?', "%#{str}%", "%#{str}%", "%#{str}%") }

  scope :get_role,    -> (str) { includes(:role).where("contact_roles.label = '#{str}'").references(:contact_roles).order('last_name') }
  scope :clients,     ->       { get_role('client') }
  scope :adversaries, ->       { get_role('adversary') }
  scope :employees,   ->       { get_role('employee') }
  scope :other,       ->       { get_role('other') }

  scope :filter_by_role,     -> (str) { where(role: str) }
  scope :filter_by_country,  -> (str) { joins(:address).where("lower(contact_addresses.country) = ?", str) }

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

  def combine(format = :name)

    formats = {
      name:      [first_name, last_name, " "],
      full_name: [prefix, first_name, last_name, suffix, " "],
      address:   [address.pobox, "#{address.street} #{address.streetno}", "#{address.zip} #{address.city}", address.country, "\n"],
      category:  "#{company ? 'Company' : 'Private person'}"
    }

    if formats[format.to_sym].is_a?(Array)
      separator = formats[format.to_sym].pop
      formats[format.to_sym].reject(&:blank?).join(separator)

    else
      formats[format.to_sym]
    end
  end

  private

  def default_values!
    self.company ||= false
  end
end
