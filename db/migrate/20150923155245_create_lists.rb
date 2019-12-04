class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.text :title
      t.integer :plan_id

      t.timestamps null: false
    end
  end
end
