class AddUserRefToProjectRoles < ActiveRecord::Migration[5.1]
  def change
    add_reference :project_roles, :user, foreign_key: true
  end
end
