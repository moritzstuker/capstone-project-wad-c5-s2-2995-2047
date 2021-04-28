class CreateDeadlines < ActiveRecord::Migration[5.1]
  def change
    create_table :deadlines do |t|
      t.string :label
      t.string :category
      t.date :date
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
