class RemoveField < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :name
  end
end
