class RenamePartiesTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :parties, :project_contacts
  end
end
