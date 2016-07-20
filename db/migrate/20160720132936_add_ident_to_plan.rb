class AddIdentToPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :ident, :string, null: false
  end
end
