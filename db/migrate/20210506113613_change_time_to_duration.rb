class ChangeTimeToDuration < ActiveRecord::Migration[5.1]
  def change
    rename_column :activities, :time, :duration
  end
end
