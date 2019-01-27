class PresentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  # お土産作成(B->F, sql->select)
  def new
    lists = Article.where(:user_id => current_user.id)
      .select("id, title")
      
    render json: {
      articleIdList: lists
    }
  end

  # お土産作成(F->B, sql->insert)
  def create
    present = Present.create!(
      :name => params[:name],
      :image => params[:files],
      :kind => params[:kind],
      :other_kind => params[:otherKind],
      :target => params[:target],
      :other_target => params[:otherTarget],
      :price => params[:price],
      :content => params[:content],
      :article_id => params[:id]
    )
    present.save!
    render :json => {message: "ok"}
  end

  # お土産編集(B->F, sql->select)
  def edit
    @articles = Article.where(:user_id => current_user.id)
      .select("id, title")
    @presents = Present.find_by(:id => params[:id])
    
    render 'edit', formats: 'json', handlers: 'jbuilder'
  end

  # お土産編集(F->B, sql->update)
  def update
    present = Present.find_by(:id => params[:id])
    present.update!(
      :name => params[:name],
      :image => params[:files],
      :kind => params[:kind],
      :other_kind => params[:otherKind],
      :target => params[:target],
      :other_target => params[:otherTarget],
      :price => params[:price],
      :content => params[:content],
      :article_id => params[:id]
    )

    render :json => {message: "ok"}
  end

  # お土産詳細
  def detail
    user = User.find_by("name = ?", params[:name])
    @articles = Article.where(:user_id => user.id)
      .select("id, title")
    @presents = Present.find_by(:id => params[:id])
    
    render 'detail', formats: 'json', handlers: 'jbuilder'
  end
end
