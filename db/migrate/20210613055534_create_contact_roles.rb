class CreateContactRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_roles do |t|
      t.string :label
      t.string :color

      t.timestamps
    end
  end
end
