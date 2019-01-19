json.(@plan, :title, :description)
json.new_list_path "#{plan_lists_path(@plan)}.json"
json.lists @lists do |list|
  json.(list, :id, :title, :color_tag)
  json.color_tag_class color_tag_class('panel-', list.color_tag)
  json.path "#{plan_list_path(@plan, list)}"
  json.tasks list.tasks do |task|
    json.(task, :title, :status)
    json.status_class task.status == 0 ? 'closed-task' : ''
    json.path plan_list_task_path(@plan, list, task)
  end
end