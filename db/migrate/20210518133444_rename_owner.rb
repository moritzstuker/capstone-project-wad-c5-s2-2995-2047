class RenameOwner < ActiveRecord::Migration[5.1]
  def change
    remove_reference :projects, :case_owner, foreign_key: true
    add_reference :projects, :owner, foreign_key: true
  end
end
