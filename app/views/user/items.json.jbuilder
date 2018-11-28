json.icon       @user.icon
json.userName   @user.name
json.intro      @user.intro

json.articles do 

  json.array!(@articles) do |articles|
    json.title        articles.title
    json.updated_at   articles.updated_at

    json.tags do
      json.array! @tags.where(id: articles.id) do |tags|
        json.tag  tags.name
      end
    end

  end

end