json.array!(@plans) do |plan|
  json.extract! plan, :title, :description
  json.color_tag color_tag_class('bs-callout-', plan.color_tag)
  json.color_tag_id plan.color_tag
  json.path plan_path(plan)
end
