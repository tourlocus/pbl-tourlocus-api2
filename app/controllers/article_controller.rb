class ArticleController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update]

  # 記事編集
  def edit
    @article = Article.find(params[:id])

    if @article.user_id != current_user.id
      render json: {message: "user error"}
    else

      @media = MediaFile
        .select("media_files.media as url")
        .where("article_id=?", @article.id)
      @tags = ArticleTag.joins(:tag)
        .select("tags.id, tags.name")
        .where("article_tags.article_id=?", @article.id)
      render 'edit', formats: 'json', handlers: 'jbuilder'
    end

  end

  # 記事編集 update
  def update
    article = Article.find(params[:id])
    article.update!(title: params[:title], content: params[:content])

    # ファイルアップロード
    files = params[:files]
    if files != nil
      old_media = MediaFile.where("article_id=?", article.id)
      if old_media.length != 0  
        old_media.delete_all
      end

      files.each do |t|
        new_media = MediaFile.create!(:media => t, :article_id => article.id)
        new_media.save!
      end
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

  # 記事作成
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

  # 記事詳細
  def show
    @article = Article.joins(:user)
      .select("articles.*, users.name, users.icon")
      .where("articles.id = ?", params[:id]).first

    if @article.name != params[:name]
      render json: {message: 'name error'}
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

      if @article.user_id != current_user.id then
        Article.find(params[:id]).increment!(:pv)
      end

      render 'show', formats: 'json', handlers: 'jbuilder'
    end
  end

  # top(main) page
  def index
    @articles = Article.joins(:user)
      .select("articles.*, users.name, users.icon")
      .order(created_at: :desc).limit(15)
    mlist = MediaFile.select("min(id) as id")
      .where(article_id: @articles.pluck("id").uniq)
      .group(:article_id).map(&:id)
    @media = MediaFile.where(id: mlist)

    @items = Article.joins(:user)
      .left_joins_media(mlist)
      .select("articles.*, users.name, users.icon, media_files.media")
      .order(created_at: :desc).limit(15)
      .order("point DESC").limit(15)

    render 'index', formats: 'json', handlers: 'jbuilder'
  end

end