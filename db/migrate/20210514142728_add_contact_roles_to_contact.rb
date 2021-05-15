class AddContactRolesToContact < ActiveRecord::Migration[5.1]
  def change
    add_reference :contacts, :contact_role, foreign_key: true
  end
end
