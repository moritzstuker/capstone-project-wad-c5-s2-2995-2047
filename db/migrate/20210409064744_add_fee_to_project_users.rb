class AddFeeToProjectUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :project_users, :fee, :decimal, precision: 10, scale: 2
  end
end
