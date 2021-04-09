class CreateTimeEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :time_entries do |t|
      t.string :label
      t.string :type
      t.date :date
      t.time :time
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
