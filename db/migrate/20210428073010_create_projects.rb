class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :label
      t.text :description
      t.decimal :fee, precision: 10, scale: 2
      t.references :project_category, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
