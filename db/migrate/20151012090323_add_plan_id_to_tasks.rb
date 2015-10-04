class AddPlanIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :plan_id, :integer
  end
end
