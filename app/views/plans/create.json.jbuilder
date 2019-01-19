json.extract! @plan, :id, :title, :description, :color_tag
json.color_tag_class color_tag_class('bs-callout-', @plan.color_tag)
json.path plan_path(@plan)