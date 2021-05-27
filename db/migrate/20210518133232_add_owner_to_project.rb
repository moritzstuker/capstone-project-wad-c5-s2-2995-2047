class AddOwnerToProject < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :case_owner, foreign_key: true
  end
end
