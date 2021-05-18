class CreateProjectsUsersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :projects_users_tables do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.decimal :fee, precision: 8, scale: 2
    end
  end
end
