class ChangeTaskStatusFromDecimalToIntiger < ActiveRecord::Migration
  def change
    change_column :tasks, :status, :intiger
  end
end
