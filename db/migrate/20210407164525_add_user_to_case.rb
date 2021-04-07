class AddUserToCase < ActiveRecord::Migration[5.1]
  def change
    add_reference :cases, :user, foreign_key: true
  end
end
