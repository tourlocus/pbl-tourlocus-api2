json.items do
  json.array!(@articles) do |articles|
    json.id           articles.id
    json.user_id      articles.user_id
    json.user_icon    articles.icon
    json.user_name    articles.name
    json.media        articles.media

    #json.photo do
    #json.array! @media.where(article_id: articles.id) do |media|
    #  json.media   media.media
    #end
    #end

    json.title        articles.title
    json.content      articles.content
    json.created_at   articles.created_at
    json.updated_at   articles.updated_at
  end
end

json.popular do
end