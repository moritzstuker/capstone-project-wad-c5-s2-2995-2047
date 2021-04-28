class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :prefix
      t.string :first_name
      t.string :last_name
      t.string :suffix
      t.text :address
      t.string :phone
      t.string :email
      t.date :birthday
      t.string :profession
      t.string :role
      t.string :personality
      t.text :notes

      t.timestamps
    end
  end
end
