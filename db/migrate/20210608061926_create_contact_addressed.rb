class CreateContactAddressed < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_addresses do |t|
      t.string :pobox
      t.string :street
      t.string :streetno
      t.string :zip
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
