json.array!(@lists) do |list|
  json.extract! list, :id, :title, :plan_id
  json.url list_url(list, format: :json)
end
