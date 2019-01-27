json.id         @article.id
json.userName   @article.name
json.userIcon   @article.icon
json.title      @article.title
json.content    @article.content
json.status     @fav_status

json.tags do
  json.array!   @tags, :name
end

json.mediaFiles do
  json.array!   @media, :url
end

json.comment do 
  json.array!   @comments,  :userIcon,  :userName,  :comment
end

json.presents do
  json.array!(@presents) do |present|
    json.id present.id
    json.name present.name
    json.image present.image.url
    json.kind present.kind
    json.other_kind present.other_kind
    json.target present.target
    json.other_target present.other_target
    json.price present.price
    json.content present.content
  end
end

json.created_at @article.created_at
json.updated_at @article.updated_at 
