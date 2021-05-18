class DropTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :projects_users
    drop_table :projects_users_tables
  end
end
