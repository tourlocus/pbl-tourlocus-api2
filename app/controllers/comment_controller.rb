class CommentController < ApplicationController
  before_action :authenticate_user!, only: [:get, :post, :put, :delete]


  # コメントの取得
  def get
    comment = Comment.find(params[:id])

    if comment.user_id != current_user.id then
      render :json => { error: "コメントを取得する権限がありません" }, status: 401
    elsif
      render :json =>  {
        id: comment.id,
        comment: comment.comment,
      }
    end
  end

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
    render :json => { message: "コメントを作成しました" }
  end

  # コメントの更新
  def update
    comment = Comment.find(params[:id])
    if comment != nil 
      comment.update!(comment: params[:comment])
    end
    render :json => { message: "コメントを更新しました" }
  end

  def delete
    comment = Comment.find(params[:id])

    if comment.user_id != current_user.id then
      render :json => { error: "コメントを削除する権限がありません" }, status: 401
    elsif
      comment.delete
      render :json => { message: "コメントを削除しました" }
    end
  end
  
end
