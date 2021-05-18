class RenameMainToMainClient < ActiveRecord::Migration[5.1]
  def change
    rename_column :project_contacts, :main, :main_party
  end
end
