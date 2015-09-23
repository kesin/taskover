class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :title
      t.text :description
      t.decimal :status

      t.timestamps null: false
    end
  end
end
