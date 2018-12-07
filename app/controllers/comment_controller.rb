class CommentController < ApplicationController

  # コメント投稿
  def post
    comment = params[:comment]
    if comment != nil 
      Comment.create!(
        :comment => comment, 
        :user_id => params[:user_id], 
        :article_id => params[:article_id]
      )
    end

    render :json => { message: "ok" }
  end

end
