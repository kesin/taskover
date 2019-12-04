class AddColorTagToPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :color_tag, :integer , :default => 1
  end
end
