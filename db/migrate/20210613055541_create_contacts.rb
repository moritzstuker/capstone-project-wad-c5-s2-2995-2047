class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :prefix
      t.string :first_name
      t.string :last_name
      t.string :activity
      t.string :phone
      t.string :email
      t.string :pobox
      t.string :street
      t.string :streetno
      t.string :zip
      t.string :city
      t.string :country
      t.integer :category
      t.text :notes
      t.references :contact_role, foreign_key: true

      t.timestamps
    end
  end
end
