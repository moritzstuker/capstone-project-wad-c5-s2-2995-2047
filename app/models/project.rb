class Project < ApplicationRecord
  include Filtering

  enum status: {
    active: 1,
    inactive: 0
  }

  belongs_to :category, class_name: 'ProjectCategory', foreign_key: "project_category_id", optional: true
  belongs_to :owner, class_name: 'User'
  has_many   :activities, dependent: :destroy
  has_many   :deadlines, dependent: :destroy
  has_and_belongs_to_many :contacts
  has_and_belongs_to_many :adversaries, -> { adversaries }, class_name: 'Contact'
  has_and_belongs_to_many :clients,     -> { clients },     class_name: 'Contact'

  validates :label, presence: true, length: { in: 2..50 }
  validates :reference, presence: false, length: { maximum: 50 }
  validates :owner, presence: true

  scope :search_in_label,     -> (str) { where('lower(label) LIKE ?', "%#{str}%") }
  scope :search_in_reference, -> (str) { where('lower(reference) LIKE ?', "%#{str}%") }

  scope :filter_by_category, -> (str) { where(category: str).distinct }
  scope :filter_by_status,   -> (str) { where(status: str) }
  scope :filter_by_owner,    -> (str) { where(owner: str) }
  scope :filter_by_query,    -> (str) { search_in_label(str).or(search_in_reference(str)) }

  accepts_nested_attributes_for :activities

  after_initialize :set_defaults

  def self.with_category(category, query = nil)
    filter_by_query(query).filter_by_category(category)
  end

  private

  def set_defaults
    if self.new_record?
      self.status ||= 1
    end
  end
end
