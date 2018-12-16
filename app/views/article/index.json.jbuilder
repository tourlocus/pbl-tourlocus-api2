json.items do
  json.array!(@items) do |items|
    json.id           items.id
    json.user_id      items.user_id
    json.user_icon    items.icon
    json.user_name    items.name
    json.media        items.media
    json.title        items.title
    json.content      items.content
    json.created_at   items.created_at
    json.updated_at   items.updated_at
  end
end

json.popular do
  json.array!(@popular) do |popular|
    json.id           popular.id
    json.user_id      popular.user_id
    json.user_icon    popular.icon
    json.user_name    popular.name
    json.media        popular.media
    json.title        popular.title
    json.content      popular.content
    json.created_at   popular.created_at
    json.updated_at   popular.updated_at
  end
end