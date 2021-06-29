class Activity < ApplicationRecord
  CATEGORIES = %w(Email/Letter Meeting Phone\ call Court\ hearing)

  belongs_to :project
  belongs_to :user
end
