class Contact < ApplicationRecord
  include Filtering
  include HTTParty # This is to perform API requests

  enum category: {
    person:  0,
    company: 1
  }

  belongs_to              :role, class_name: 'ContactRole', foreign_key: 'contact_role_id'
  has_and_belongs_to_many :projects

  validates :name, presence: true, length: { in: 2..100 }
  validates :email, presence: false, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { allow_blank: true }
  validates :street, presence: false, length: { in: 2..50 }
  validates :city, presence: false, length: { in: 2..50 }
  validates :country, presence: true
  validates :category, presence: true
  validates :role, presence: true
  validates :import_uid, uniqueness: { allow_blank: true }

  scope :get_role,    -> (str) { includes(:role).where("contact_roles.label = '#{str}'").references(:contact_roles) }
  scope :clients,     ->       { get_role('client') }
  scope :adversaries, ->       { get_role('adversary') }
  scope :other,       ->       { get_role('other') }

  scope :search_in_name,    -> (str) { where('name LIKE ?', "%#{str}%") }
  scope :search_in_street,  -> (str) { where('street LIKE ?', "%#{str}%") }
  scope :search_in_city,    -> (str) { where('city LIKE ?', "%#{str}%") }
  scope :search_in_country, -> (str) { where('country LIKE ?', "%#{str}%") }

  scope :filter_by_role,     -> (str) { where(role: str.to_i) }
  scope :filter_by_category, -> (str) { where(category: str.to_i) }
  scope :filter_by_country,  -> (str) { where('lower(country) = ?', str.downcase) }
  scope :filter_by_query,    -> (str) {
    search_in_name(str)
    .or(search_in_street(str))
    .or(search_in_city(str))
    .or(search_in_country(str))
  }

  after_initialize :set_defaults

  def self.with_role(role, query = nil)
    filter_by_query(query).filter_by_role(role.id)
  end

  def friendly_name
    "#{ name } (#{ city })"
  end

  private

  def set_defaults
    if self.new_record?
      self.category ||= 1
      self.name     ||= 'John Doe'
    end
  end
end
