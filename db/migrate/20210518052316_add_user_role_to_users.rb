class AddUserRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :access_level
    add_reference :users, :user_role, foreign_key: true
  end
end
