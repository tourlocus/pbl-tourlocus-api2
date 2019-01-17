class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :media_files, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :presents, dependent: :destroy

  # 受け取ったmedia_filesのIDを用いて、articlesとmedia_filesを左結合
  def self.left_joins_media(mlist)
    joins(sanitize_sql_array(['LEFT OUTER JOIN media_files ON media_files.article_id = articles.id AND media_files.id IN (?)', mlist]))
  end

  # 人気順のポイント計算
  # (pv数+1) * 100,000 / (今日の日付+1と記事投稿日の差)^1.5
  def self.select_popular_as_pv
    select("(articles.pv+1) * 100000 / POW(DATEDIFF(CURDATE()+1, articles.created_at), 1.5) AS pv")
  end

  # 検索
  def self.search_word(word)
    find_by_sql(['
      SELECT DISTINCT
        articles.*,
        users.name,
        users.icon,
        (
          SELECT
            media
          FROM
            media_files, articles
          WHERE
            media_files.article_id = articles.id
          ORDER BY
            media
          DESC LIMIT 1 
        ) as "media"
      FROM
        articles
      INNER JOIN
        article_tags
      ON
        articles.id = article_tags.article_id
      INNER JOIN
        tags
      ON
        tags.id = article_tags.tag_id
      INNER JOIN
        users
      ON
        articles.user_id = users.id
      WHERE
        (tags.name in (:word))
      OR
        articles.title LIKE "%:word%"
    ', {:word => word}])
  end
end
