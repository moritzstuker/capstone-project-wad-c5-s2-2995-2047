class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :phone
      t.string :email
      t.string :profession
      t.string :role
      t.text :notes

      t.timestamps
    end
  end
end
