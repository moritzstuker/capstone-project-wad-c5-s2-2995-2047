class ChangeOneField < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :preferred_lang, :string
  end
end
