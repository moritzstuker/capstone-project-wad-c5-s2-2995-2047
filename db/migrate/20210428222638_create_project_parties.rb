class CreateProjectParties < ActiveRecord::Migration[5.1]
  def change
    create_join_table :projects, :contacts
  end
end
