class ArticleController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update]
  # 定数 #
  DISPLAY = 15  #記事の表示件数(現状トップページのみ)

  #---------------------------------------
  # 記事編集
  #---------------------------------------
  def edit
    @article = Article.find(params[:id])
    # 記事を書いたユーザーが自分かどうか
    if @article.user_id != current_user.id
      render json: {message: "user error"}, status: 401
    else
      @media = MediaFile
        .select("media_files.media as url")
        .where("article_id=?", @article.id)
      @tags = ArticleTag.joins(:tag)
        .select("tags.id, tags.name")
        .where("article_tags.article_id=?", @article.id)
    end
    render 'edit', formats: 'json', handlers: 'jbuilder'
  end
  #--------------------------------------
  # 記事編集 update
  #-------------------------------------
  def update
    article = Article.find(params[:id])
    article.update!(title: params[:title], content: params[:content])

    # ファイルアップロード
    files = params[:files]
    # ファイルがあれば古いファイル情報をデータベースから除く
    if files != nil
      old_media = MediaFile.where("article_id=?", article.id)
      if old_media.length != 0  
        old_media.delete_all
      end
      files.each do |t|
        new_media = MediaFile.create!(:media => t, :article_id => article.id)
        new_media.save!
      end
    else
      # ファイルがなければ何もしない
      p ""
    end
    tags = params[:tags]
    if tags != nil
      old_article_tag = ArticleTag.where("article_id=?", article.id)

      if old_article_tag.length != 0
        old_article_tag.delete_all
      end
      
      tags.split(',').each do |t|
        tag_name = Tag.find_or_create_by!(name: t)
        ArticleTag.create!(:article_id => article.id, :tag_id => tag_name["id"])
      end
    end
    render json: {message: "ok"}
  end
  #---------------------------------------------
  # 記事作成
  #---------------------------------------------
  def create
    article = Article.create!(:title => params[:title], :content => params[:content], :user_id => current_user.id)
    article_id = article.id

    files = params[:files]
    if files != nil
      files.each do |t|
        media = MediaFile.create!(:media => t, :article_id => article_id)
        media.save!
      end
    end

    tags = params[:tags]
    if tags != nil
      tags.split(',').each do |t|
        tag_name = Tag.find_or_create_by!(name: t)
        ArticleTag.create!(:article_id => article_id, :tag_id => tag_name["id"]) 
      end
    end
    render :json => {message: 'ok'}
  end
  #------------------------------------
  # 記事詳細
  #------------------------------------
  def show
    @article = Article.joins(:user)
      .select("articles.*, users.name, users.icon")
      .where("articles.id = ?", params[:id]).first

    # 記事を書いた人とparamの名前が違う人だった場合
    if @article.name != params[:name]
      render json: {message: 'name error'}, status: 401
    else
      @tags = ArticleTag.joins(:tag)
        .select("tags.name")
        .where("article_tags.article_id = ?", params[:id])

      @media = MediaFile.joins(:article)
        .select("media_files.media as url")
        .where("articles.id = ?", params[:id])

      @fav_status = User.left_joins(:favorites)
        .select("users.id, favorites.article_id, favorites.status")
        .where("favorites.article_id = ?", params[:id])
        .where("users.name = ?", params[:name])
        .where("favorites.status", true).exists?

      @comments = Comment.joins(:user)
        .select("users.icon as userIcon, users.name as userName, comments.comment as comment")
        .where("comments.article_id = ?", params[:id])

      render 'show', formats: 'json', handlers: 'jbuilder'
    end
  end
  #-------------------------------------
  # 記事一覧
  #------------------------------------
  def index
    list = Article.order(created_at: :desc)
    l_mlist = MediaFile.select_media_list(list)
    p l_mlist

    @newItems = Article.select_new
    @popularItem = Article.select_popular

    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  #-------------------------------------
  # 記事検索
  #------------------------------------
  def search
    search_word = params[:word]

    @items = []
    search_word.split(' ').each do |word|
      @items += Article.search_word(word)
    end

    render 'search', formats: 'json', handlers: 'jbuilder'
  end


end