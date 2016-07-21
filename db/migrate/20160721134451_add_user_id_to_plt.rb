class AddUserIdToPlt < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :user_id, :integer, null: false
    add_column :lists, :user_id, :integer, null: false
    add_column :tasks, :user_id, :integer, null: false
  end
end
