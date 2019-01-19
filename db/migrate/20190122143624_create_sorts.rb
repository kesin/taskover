class CreateSorts < ActiveRecord::Migration[5.2]
  def change
    create_table :sorts do |t|
      t.integer :sortable_id, null: false
      t.string :sortable_type, null: false
      t.text :sort, null: false
    end
  end
end
