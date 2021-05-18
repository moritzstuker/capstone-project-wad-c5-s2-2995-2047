class AddUserRolesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :user_roles do |t|
      t.string :label
      t.integer :access_level
      t.decimal :default_fee, precision: 6, scale: 2

      t.timestamps
    end
  end
end
