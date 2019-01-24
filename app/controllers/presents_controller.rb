class PresentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  # お土産作成(B->F, sql->select)
  def new
    created_list = Article.joins(:presents)
      .where(:user_id => current_user.id)
      .pluck("id").uniq
    articles = Article.where(:user_id => current_user.id)
      .where.not(id: created_list)
      .select("id, title")
      .order("created_at DESC")
    render json:{
      articleIdList: articles,
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
    # # 受け取った記事(ID)が、ログインユーザー作成のもの出ない場合、エラー
    # user = Article.find_by(:id => params[:id])
    # if user.user_id != current_user.id
    #   render json: {message: "error"}
    # else
    #   present_data = Present.find_by(:article_id => params[:id])
    #   render json: {
    #     article_name: user.title,
    #     article_id: params[:id],
    #     present_name: present_data.name,
    #     present_amount: present_data.num,
    #     present_price: present_data.price,
    #     required: present_data.target,
    #     impression: present_data.content,
    #     photo: present_data.image.url,
    #   }
    # end
    @articles = Article.where(:user_id => current_user.id)
      .select("id, title")
    @presents = Present.find_by(:id => params[:id])

    render 'edit', formats: 'json', handlers: 'jbuilder'
  end

  # お土産編集(F->B, sql->update)
  def update
    present_data = Present.find_by(:article_id => params[:article_id])
    # お土産テーブルをupdate
    present_data.update!(
      :name => params[:present_name],
      :num => params[:present_amount],
      :price => params[:present_price],
      :target => params[:required],
      :content => params[:impression],
      :article_id => params[:article_id],
    )

    # ファイルアップロード
    if params[:photo] != nil
      present_data.update!(:image => nil)
    else
      new_image = present_data.update!(:image => params[:photo])
      new_image.save!
    end

    render :json => {message: "ok"}
  end
end
