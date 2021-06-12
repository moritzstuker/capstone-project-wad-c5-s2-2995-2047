class RemoveSuffixFromContacts < ActiveRecord::Migration[5.1]
  def change
    remove_column :contacts, :suffix
  end
end
