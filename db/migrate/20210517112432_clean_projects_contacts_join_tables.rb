class CleanProjectsContactsJoinTables < ActiveRecord::Migration[5.1]
  def change
    drop_join_table :projects, :clients
    drop_join_table :projects, :adversaries
    drop_join_table :projects, :employees
    create_join_table :projects, :contacts
  end
end
