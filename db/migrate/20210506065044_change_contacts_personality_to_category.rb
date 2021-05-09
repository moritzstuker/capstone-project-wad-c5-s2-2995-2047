class ChangeContactsPersonalityToCategory < ActiveRecord::Migration[5.1]
  def change
    rename_column :contacts, :personality, :category
  end
end
