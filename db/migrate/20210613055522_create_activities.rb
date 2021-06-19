class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :label
      t.string :category
      t.date :date
      t.decimal :duration, precision: 10, scale: 2
      t.decimal :fee, precision: 10, scale: 2
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
