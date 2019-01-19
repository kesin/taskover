json.array!(@plans) do |plan|
  json.extract! plan, :title, :description, :color_tag, :id
  json.color_tag_class color_tag_class('bs-callout-', plan.color_tag)
  json.path plan_path(plan)
end
