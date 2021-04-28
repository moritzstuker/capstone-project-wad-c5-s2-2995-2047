class CreateProjectCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :project_categories do |t|
      t.string :label
      t.string :color

      t.timestamps
    end
  end
end
