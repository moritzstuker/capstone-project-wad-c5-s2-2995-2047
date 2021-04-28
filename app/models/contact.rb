class Contact < ApplicationRecord

  ROLES = %w(client adversary employee other).freeze
  PERSONALITIES = %w(natural legal).freeze
  FORMATS = {
    string: {
      name:        '#{first_name} #{last_name}',
      short_name:  '#{first_name.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{last_name}',
      long_name:   '#{prefix} #{first_name} #{last_name} #{suffix}',
      initials:    '#{first_name.to_s.gsub(/(([[:alpha:]])[[:alpha:]]*\.?)/, \'\2.\')} #{last_name.to_s.chars.first}.',
      address:     '#{address[:pobox]}<br>#{address[:street]}&nbsp;#{address[:streetno]}<br>#{address[:zip]}&nbsp;#{address[:city]}<br>#{address[:country]}',
      city:        '#{address[:zip]} #{address[:city]} (#{address[:country]})',
      street:      '#{address[:street]} #{address[:streetno]}',
      personality: '#{personality == \'natural\' ? \'Private person\' : \'Company\'}',
      role:        '#{role.titleize}'
    },
    order: {
      name: %w(last_name first_name id),
      city: %w(address[:city] address[:zip] address[:country] id),
      role: %w(role created_at)
    }
  }

  has_one :user

  scope :first_name_contains, -> (str) { where('first_name LIKE ?', "%#{str}%") }
  scope :last_name_contains,  -> (str) { where('last_name LIKE ?', "%#{str}%") }
  scope :address_contains,    -> (str) { where('address LIKE ?', "%#{str}%") }
  scope :search,              -> (str) { first_name_contains(str).or(last_name_contains(str)).or(address_contains(str)) }

  after_initialize  :default_values!
  before_validation { self.email = email.downcase }

  validates :first_name, length: { maximum: 60 }
  validates :last_name,  presence: true, length: { maximum: 60 }
  validates :email,      presence: true, length: { minimum: 6, maximum: 60 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :role,       inclusion: { in: ROLES }

  serialize :address, Hash

  def combine(format = :name)
    eval('"' + FORMATS[:string][format] + '"').gsub(/^\s*(?:<br\s*\/?\s*>)+|(?:<br\s*\/?\s*>)+\s*$/i, "").gsub(/\s+/, " ").strip.html_safe
  end

  private

  def default_values!
    self.role ||= "other"
  end
end
