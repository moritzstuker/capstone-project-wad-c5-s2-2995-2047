class RenameUserRolesToAccessLevels < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :role, :access_level
  end
end
