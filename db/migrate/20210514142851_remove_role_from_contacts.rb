class RemoveRoleFromContacts < ActiveRecord::Migration[5.1]
  def change
    remove_column :contacts, :role
  end
end
