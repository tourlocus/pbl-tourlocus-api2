json.id       @article.id
json.title    @article.title
json.content  @article.content

json.mediaFiles do 
  json.array! @media, :url
end

json.tags do 
  json.array! @tags, :name
end