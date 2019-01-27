class FavoriteController < ApplicationController
  before_action :authenticate_user!, only: [:post, :delete]

  #-----------------------------------------
  # お気に入り登録
  #-----------------------------------------
  def post
    favorite = Favorite.create!(
      :status => true,
      :user_id => current_user.id,
      :article_id => params[:id]
    )
    favorite.save!

    render json: {message: 'ok'}
  end

  #-----------------------------------------
  # お気に入り削除
  #-----------------------------------------
  def delete
    Favorite.where("article_id = ? AND user_id =?", params[:id], current_user.id)
      .delete_all
    
    render json: {message: 'ok'}
  end

end
