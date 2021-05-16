class CreateParties < ActiveRecord::Migration[5.1]
  def change
    create_table :parties do |t|
      t.belongs_to :contact
      t.belongs_to :project
      t.boolean :main
    end
  end
end
