class Party < ApplicationRecord
  belongs_to :contacts
  belongs_to :projects
end
