class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.text :title
      t.text :description
      t.integer :status, :default => 1
      t.integer :list_id

      t.timestamps null: false
    end
  end
end
