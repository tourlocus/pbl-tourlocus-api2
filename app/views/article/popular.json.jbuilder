json.popular do
  json.array!(@popular) do |popular|
    json.id           popular.id
    json.user_id      popular.user_id
    json.user_icon    popular.icon
    json.user_name    popular.name
    json.media        popular.media
    json.title        popular.title
    json.content      popular.content
    json.popular      popular.pv
    json.created_at   popular.created_at
    json.updated_at   popular.updated_at
  end
end