class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.string :avatar
      t.string :role
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
