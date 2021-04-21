class AddPersonalityToContact < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :personality, :string, after: :role
  end
end
