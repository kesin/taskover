json.(@plan, :title, :description)
json.new_list_path "#{plan_lists_path(@plan)}.json"
json.lists @lists do |list|
  json.(list, :id, :title, :color_tag)
  json.color_tag_class color_tag_class('panel-', list.color_tag)
  json.path "#{plan_list_path(@plan, list)}" # TODO remove path use list.id instead
  sort = list.task_sort.nil? ? list.tasks.pluck(:id) : list.task_sort.sort
  tasks = list.tasks.sort_by{|e| sort.index(e.id)}
  tasks = tasks.group_by(&:status)
  json.tasks tasks[1] do |task|
    json.(task, :id, :title, :status)
    json.status_class ''
    json.path plan_list_task_path(@plan, list, task)
  end
  json.over_tasks tasks[0] do |task|
    json.(task, :id, :title, :status)
    json.status_class 'closed-task'
    json.path plan_list_task_path(@plan, list, task)
  end
end