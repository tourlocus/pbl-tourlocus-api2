json.icon       @user.icon
json.user_name  @user.name
json.intro      @user.intro
json.follow     @follow
json.follower   @follower

# 自分の記事
json.articles do 
  json.array!(@articles) do |articles|
    json.article_id   articles.id
    json.title        articles.title
    json.updated_at   articles.updated_at

    json.tags do
      json.array! @tags.where(id: articles.id) do |tags|
        json.tag  tags.name
      end
    end
  end
end

# お気に入り
json.favorites do
  json.array!(@favorites) do |favorites|
    json.article_id  favorites.articleID
    json.title       favorites.title
    json.user_name   favorites.name
    json.icon_image  favorites.icon
    json.updated_at  favorites.updated_at

    json.tags do
      json.array! @tags.where(id: favorites.articleID) do |tags|
        json.tag tags.name
      end
    end
  end
end