class SwitchPersonToBool < ActiveRecord::Migration[5.1]
  def change
    remove_column :contacts, :category
    add_column :contacts, :company, :boolean
  end
end
