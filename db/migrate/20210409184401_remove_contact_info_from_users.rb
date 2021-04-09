class RemoveContactInfoFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :email
    add_reference :users, :contact, index: true
  end
end
