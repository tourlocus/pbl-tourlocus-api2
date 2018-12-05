class UserController < ApplicationController

  # ユーザーページ記事一覧
  def items
    user = User.find_by("name = ?", params[:name])
    @user = User.find(user.id)

    @articles = Article.where("user_id = ?", user.id)
      .order("updated_at DESC")
    @favorites = User.joins({:articles => :favorites})
      .select("users.id, users.icon, users.name, articles.id as articleID, articles.title, articles.updated_at")
      .where("favorites.status = ?", true)
      .where("favorites.user_id = ?", user.id)
    @tags = Article.left_joins({:article_tags => :tag})
      .where("user_id = ?", user.id)
      .select("articles.id, tags.name")
    render 'items', formats: 'json', handlers: 'jbuilder'
  end

end
