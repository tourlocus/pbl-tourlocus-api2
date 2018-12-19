class FavoriteController < ApplicationController
  def update
    status = Favorite.where("article_id = ?", params[:id])
    status.update(:user_id => current_user.id, :article_id => params[:id], :status => params[:status])

    render :json => status.status
  end  
end
