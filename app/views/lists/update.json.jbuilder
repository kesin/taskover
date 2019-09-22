json.extract! @list, :id, :title, :color_tag
json.color_tag_class color_tag_class('panel-', @list.color_tag)