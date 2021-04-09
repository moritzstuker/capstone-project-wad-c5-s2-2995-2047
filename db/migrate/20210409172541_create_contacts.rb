class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email
      t.text :address
      t.string :type

      t.timestamps
    end
  end
end
