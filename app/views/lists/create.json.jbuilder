json.extract! @list, :title, :color_tag
json.color_tag_class color_tag_class('panel-', @list.color_tag)
json.path "#{plan_list_path(@plan, @list)}"
json.tasks []