class RemoveCaseOwnerFromAssignments < ActiveRecord::Migration[5.1]
  def change
    remove_column :assignments, :case_owner
  end
end
