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


json.created_at @article.created_at
json.updated_at @article.updated_at 
