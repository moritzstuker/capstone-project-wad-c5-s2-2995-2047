class AddProjectOwnerToProjectsUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :projects_users, :case_owner, :boolean
  end
end
