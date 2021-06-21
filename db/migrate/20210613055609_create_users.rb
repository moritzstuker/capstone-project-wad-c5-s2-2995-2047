class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login
      t.string :name
      t.string :password_digest
      t.string :avatar
      t.string :email
      t.string :locale
      t.integer :role
      t.decimal :default_fee, precision: 10, scale: 2

      t.timestamps
    end
  end
end
