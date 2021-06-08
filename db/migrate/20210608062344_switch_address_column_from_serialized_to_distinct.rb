class SwitchAddressColumnFromSerializedToDistinct < ActiveRecord::Migration[5.1]
  def change
    remove_column :contacts, :address
    add_reference :contacts, :contact_address, foreign_key: true
  end
end
