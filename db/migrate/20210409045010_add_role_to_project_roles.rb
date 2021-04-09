class AddRoleToProjectRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :project_roles, :role, :string
  end
end
