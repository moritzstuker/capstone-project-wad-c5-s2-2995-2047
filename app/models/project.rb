class Project < ApplicationRecord
  include Filtering

  STATUS = [
    'active',
    'inactive'
  ].freeze

  FORMATS = {
    label:              '[obj.label, " "]',
    label_with_parties: '[obj.label, "<span class=\"mute\">(#{main_parties(obj, false)})</span>", " "]',
  }

  has_many                :activities
  has_and_belongs_to_many :adversaries, -> { adversaries }, class_name: "Contact"
  has_many                :assignments
  has_many                :assignees, through: :assignments, source: :user
  belongs_to              :category, class_name: "ProjectCategory", foreign_key: "project_category_id", optional: true
  has_and_belongs_to_many :clients, -> { clients }, class_name: "Contact"
  has_many                :deadlines
  belongs_to              :owner, class_name: "User"

  scope :label_contains,     -> (str) { where('label LIKE ?', "%#{str}%") }
  scope :reference_contains, -> (str) { where('reference LIKE ?', "%#{str}%") }
  scope :search,             -> (str) { label_contains(str).or(reference_contains(str)) }

  scope :filter_by_category, -> (str) { where(category: str).distinct }
  scope :filter_by_status,   -> (str) { where(status: str).distinct }
  scope :filter_by_user,     -> (str) { includes(:assignments).where("projects.owner_id = ? OR assignments.user_id = ?", str, str).references(:assignments).distinct } # Went for SQL because: https://stackoverflow.com/questions/40742078/relation-passed-to-or-must-be-structurally-compatible-incompatible-values-r/40742611#comment-68712244

  validates :label,    presence: true

  after_validation :default_values!

  private

  def default_values!
    self.status ||= 'active'
  end
end
