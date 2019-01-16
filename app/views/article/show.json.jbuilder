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

if @present != nil
  json.present do
    json.present_name     @present.name
    json.present_amount   @present.num
    json.present_price    @present.price
    json.required         @present.target
    json.impression       @present.content
    json.photo            @present.url
  end
else
  json.present nil
end