class UserController < ApplicationController
  
  def items
    user = User.find_by("name=?", params[:name])
    @user = User.find(user.id)
    @articles = Article.where("user_id=?", user.id)
    @tags = Article.left_joins({:article_tags => :tag})
                   .where("user_id=?", user.id)
                   .select("articles.id, tags.name")
    
    render 'items', formats: 'json', handlers: 'jbuilder'
  end

end
