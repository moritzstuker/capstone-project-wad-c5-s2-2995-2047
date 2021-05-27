class AddUsersToDeadlines < ActiveRecord::Migration[5.1]
  def change
    add_reference :deadlines, :assignee, foreign_key: true
  end
end
