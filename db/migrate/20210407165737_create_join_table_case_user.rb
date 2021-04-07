class CreateJoinTableCaseUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cases, :users do |t|
      # t.index [:case_id, :user_id]
      # t.index [:user_id, :case_id]
    end
  end
end
