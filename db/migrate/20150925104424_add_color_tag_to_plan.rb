class AddColorTagToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :color_tag, :integer , :default => 1
  end
end
