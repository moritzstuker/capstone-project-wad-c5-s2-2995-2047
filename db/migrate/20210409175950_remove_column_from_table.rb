class RemoveColumnFromTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :contacts, :type
  end
end
