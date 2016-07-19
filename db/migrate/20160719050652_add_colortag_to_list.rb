class AddColortagToList < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :color_tag, :integer, default: 0
  end
end
