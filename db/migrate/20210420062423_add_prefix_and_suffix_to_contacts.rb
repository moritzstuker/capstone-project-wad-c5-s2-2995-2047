class AddPrefixAndSuffixToContacts < ActiveRecord::Migration[5.1]
  def change
    rename_column :contacts, :title, :prefix
    add_column :contacts, :suffix, :string, after: :last_name
  end
end
