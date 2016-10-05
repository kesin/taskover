json.(@plan, :title, :description)
json.new_list_path "#{plan_lists_path(@plan)}.json"
json.lists @lists do |list|
  json.(list, :title, :color_tag)
  json.color_tag_class color_tag_class('panel-', list.color_tag)
  json.new_task_path "#{plan_list_tasks_path(@plan, list)}.json"
  json.tasks list.tasks do |task|
    json.(task, :title, :status)
    json.status_class task.status == 0 ? 'closed-task' : ''
  end
end