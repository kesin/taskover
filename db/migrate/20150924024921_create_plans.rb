class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.text :title
      t.text :description

      t.timestamps null: false
    end
  end
end
