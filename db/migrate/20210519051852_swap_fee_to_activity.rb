class SwapFeeToActivity < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :fee, :decimal, :precision => 10, :scale => 2
    change_column :assignments, :fee, :decimal, :precision => 10, :scale => 2
    rename_column :assignments, :fee, :default_fee
    change_column :user_roles, :default_fee, :decimal, :precision => 10, :scale => 2
  end
end
