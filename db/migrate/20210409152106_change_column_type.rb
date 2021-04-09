class ChangeColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :time_entries, :time, :decimal, :precision => 10, :scale => 2
  end
end
