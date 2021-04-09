class RenameProjectRolesToProjectUsers < ActiveRecord::Migration[5.1]
  def change
    rename_table :project_roles, :project_users
  end
end
