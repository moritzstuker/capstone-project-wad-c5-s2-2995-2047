class RemoveFeeFromProject < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :fee
  end
end
