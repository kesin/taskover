json.array!(@plans) do |plan|
  json.extract! plan, :id, :title, :description
  json.color_tag color_tag_class('bs-callout-', plan.color_tag)
  json.path plan_path(plan)
end
