class AddProjectRefToProjectRoles < ActiveRecord::Migration[5.1]
  def change
    add_reference :project_roles, :project, foreign_key: true
  end
end
