json.search do
  json.array!(@items) do |items| 
    json.id items.id
    json.user_id items.user_id
    json.user_name items.name
    json.user_icon items.icon
    json.title items.title
    json.media items.media
    json.content items.content
    json.created_at items.created_at
    json.updated_at items.updated_at
  end
end