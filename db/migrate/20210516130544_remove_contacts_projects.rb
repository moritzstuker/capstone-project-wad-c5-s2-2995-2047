class RemoveContactsProjects < ActiveRecord::Migration[5.1]
  def change
    drop_table :contacts_projects
  end
end
