class CreateJoinTableContactProject < ActiveRecord::Migration[5.1]
  def change
    create_join_table :contacts, :projects do |t|
      # t.index [:contact_id, :project_id]
      # t.index [:project_id, :contact_id]
    end
  end
end
