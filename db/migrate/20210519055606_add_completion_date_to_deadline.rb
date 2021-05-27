class AddCompletionDateToDeadline < ActiveRecord::Migration[5.1]
  def change
    add_column :deadlines, :completed_at, :datetime
  end
end
