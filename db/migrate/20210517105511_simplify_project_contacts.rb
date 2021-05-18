class SimplifyProjectContacts < ActiveRecord::Migration[5.1]
  def change
    drop_table :project_contacts
    remove_column :projects, :name
  end
end
