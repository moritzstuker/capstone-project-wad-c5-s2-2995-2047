class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :activity
      t.string :email
      t.string :street
      t.string :city
      t.string :country
      t.integer :category
      t.text :notes
      t.string :import_uid
      t.references :contact_role, foreign_key: true

      t.timestamps
    end
  end
end
