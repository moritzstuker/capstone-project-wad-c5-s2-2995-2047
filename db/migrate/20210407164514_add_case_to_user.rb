class AddCaseToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :case, foreign_key: true
  end
end
