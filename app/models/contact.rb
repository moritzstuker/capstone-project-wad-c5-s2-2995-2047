class Contact < ApplicationRecord
  include Filtering
  include HTTParty # This is to perform API requests

  enum category: {
    person:  0,
    company: 1
  }

  belongs_to              :role, class_name: 'ContactRole', foreign_key: 'contact_role_id'
  has_and_belongs_to_many :projects

  validates :prefix, length: { maximum: 5 }
  validates :first_name, presence: false, length: { maximum: 50 }
  validates :last_name, presence: true, length: { in: 2..50 }
  validates :activity, presence: false, length: { in: 2..50 }
  validates :phone, presence: false, length: { in: 2..20 }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :pobox, presence: false, length: { maximum: 50 }
  validates :street, presence: false, length: { in: 2..50 }
  validates :streetno, presence: false, length: { maximum: 10 }
  validates :zip, presence: false, length: { in: 2..10 }
  validates :city, presence: false, length: { in: 2..50 }
  validates :country, presence: true
  validates :category, presence: true
  validates :role, presence: true

  scope :get_role,    -> (str) { includes(:role).where("contact_roles.label = '#{str}'").references(:contact_roles) }
  scope :clients,     ->       { get_role('client') }
  scope :adversaries, ->       { get_role('adversary') }
  scope :other,       ->       { get_role('other') }

  scope :search_in_first_name, -> (str) { where('first_name LIKE ?', "%#{str}%") }
  scope :search_in_last_name,  -> (str) { where('last_name LIKE ?', "%#{str}%") }
  scope :search_in_street,     -> (str) { where('street LIKE ?', "%#{str}%") }
  scope :search_in_zip,        -> (str) { where('zip LIKE ?', "%#{str}%") }
  scope :search_in_city,       -> (str) { where('city LIKE ?', "%#{str}%") }
  scope :search_in_country,    -> (str) { where('country LIKE ?', "%#{str}%") }

  scope :filter_by_role,     -> (str) { where(role: str.to_i) }
  scope :filter_by_category, -> (str) { where(category: str.to_i) }
  scope :filter_by_country,  -> (str) { where('country LIKE ?', "%#{str}%") }
  scope :filter_by_query,    -> (str) {
    search_in_first_name(str)
    .or(search_in_last_name(str))
    .or(search_in_street(str))
    .or(search_in_zip(str))
    .or(search_in_city(str))
    .or(search_in_country(str))
  }

  after_initialize :set_defaults

  def self.with_role(role, query = nil)
    filter_by_query(query).filter_by_role(role.id)
  end

  def friendly_name
    "#{ first_name } #{ last_name }"
  end

  private

  def set_defaults
    if self.new_record?
      self.category ||= 0

      if self.category.nil? || self.category == 0
        self.first_name ||= 'John'
        self.last_name ||= 'Doe'
      else
        self.last_name ||= 'ACME Inc.'
      end
    end
  end
end
