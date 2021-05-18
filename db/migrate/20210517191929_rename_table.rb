class RenameTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :project_users, :assignments
  end
end
