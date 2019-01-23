json.articleIdList do
  json.array!(@articles) do |article|
    json.id article.id
    json.title  article.title
  end
end

json.present do
  json.id @presents.id
  json.curent_article_id @presents.article_id
  json.name @presents.name
  json.file @presents.image
  json.kind @presents.kind
  json.other_kind @presents.other_kind
  json.target @presents.target
  json.other_target @presents.other_target
  json.price @presents.price
  json.content @presents.content
end