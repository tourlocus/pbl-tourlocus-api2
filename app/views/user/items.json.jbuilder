json.profile do
  json.icon       @user.icon
  json.user_name  @user.name
  json.intro      @user.intro
  json.follow     @follow
  json.follower   @follower
end

# 自分の記事
json.items do 
  json.array!(@items) do |item|
    json.id           item.id
    json.user_id      item.user_id
    json.user_icon    item.icon
    json.user_name    item.name
    json.media        item.media
    json.title        item.title
    json.content      item.content
    json.created_at   item.created_at
    json.updated_at   item.updated_at
  end
end

# お気に入り
json.favorites do
  json.array!(@favorites) do |favorite|
    json.id           favorite.id
    json.user_id      favorite.user_id
    json.user_icon    favorite.icon
    json.user_name    favorite.name
    json.media        favorite.media
    json.title        favorite.title
    json.content      favorite.content
    json.created_at   favorite.created_at
    json.updated_at   favorite.updated_at
  end

end
