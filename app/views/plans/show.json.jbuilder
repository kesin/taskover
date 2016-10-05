json.(@plan, :title, :description)
json.lists @lists do |list|
  json.(list, :title, :color_tag)
  json.color_tag_class color_tag_class('bs-callout-', list.color_tag)
  json.new_task_path new_plan_list_task_path(@plan, list)
  json.tasks list.tasks do |task|
    json.title task.title
  end
end