class Party < ApplicationRecord
  belongs_to :contact
  belongs_to :project

  after_initialize  :default_values!

  private

  def default_values!
    self.main = false
  end
end
