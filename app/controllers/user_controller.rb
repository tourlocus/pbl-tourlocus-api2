class UserController < ApplicationController

  # ユーザーページ記事一覧
  def home
    user = User.find_by("name = ?", params[:name])
    @user = User.find(user.id)
    @follow = Follow.where("user_id = ?", user.id).count
    @follower = Follow.where("follow_id = ?", user.id).count

    @items = Article.user_items(user.id)
    @favorites = Article.favorite_items(user.id)

    render 'items', formats: 'json', handlers: 'jbuilder'
  end

end
