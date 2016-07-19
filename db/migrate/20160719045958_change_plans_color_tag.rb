class ChangePlansColorTag < ActiveRecord::Migration[5.0]
  def change
    change_column :plans, :color_tag, :integer, default: 0
  end
end
