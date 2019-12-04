class AddPlanIdToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :plan_id, :integer
  end
end
