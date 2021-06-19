class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :label
      t.string :reference
      t.integer :status
      t.text :description
      t.references :owner, foreign_key: true
      t.references :project_category, foreign_key: true

      t.timestamps
    end
  end
end
