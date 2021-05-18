class CreateProjectsContactsJoinTables < ActiveRecord::Migration[5.1]
  def change
    create_join_table :projects, :clients
    create_join_table :projects, :adversaries
    create_join_table :projects, :employees
  end
end
