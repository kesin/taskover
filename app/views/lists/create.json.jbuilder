json.extract! @list, :title, :color_tag
json.color_tag_class color_tag_class('panel-', @list.color_tag)
json.new_task_path "#{plan_list_tasks_path(@plan, @list)}.json"
json.tasks []