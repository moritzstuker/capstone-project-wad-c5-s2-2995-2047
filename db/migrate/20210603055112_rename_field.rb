class RenameField < ActiveRecord::Migration[5.1]
  def change
    rename_column :contacts, :profession, :activity
    add_column :contacts, :company_id, :string
  end
end
