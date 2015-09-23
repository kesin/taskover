class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :title
      t.text :description
      t.integer :status
      t.integer :list_id

      t.timestamps null: false
    end
  end
end
