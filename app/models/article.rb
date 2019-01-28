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

  # 夏
  def self.season_items(i, j, k)
    find_by_sql(['
      SELECT
        articles.*,
        users.id as "user_id",
        users.name,
        users.icon,
        media_files.media
      FROM
        articles
      INNER JOIN
        users
      ON
        articles.user_id  = users.id
      LEFT OUTER JOIN
        media_files
      ON
        articles.id = media_files.article_id
      WHERE
        SUBSTRING(articles.created_at, 5, 7) LIKE "%" :i "%"
      OR
        SUBSTRING(articles.created_at, 5, 7) LIKE "%" :j "%"
      OR
        SUBSTRING(articles.created_at, 5, 7) LIKE "%" :k "%"
      GROUP BY
        id
      ORDER BY
        created_at
      DESC
      ', {:i => i, :j => j, :k => k}
    ])
  end

  # 自分の記事一覧
  # -----------------------------------------
  def self.user_items(id)
    find_by_sql(['
      SELECT
        articles.*,
        users.id as "user_id",
        users.name,
        users.icon,
        media_files.media
      FROM
        articles
      INNER JOIN
        users
      ON
        articles.user_id = :id
      LEFT OUTER JOIN
        media_files
      ON
        articles.id = media_files.article_id 
      GROUP BY
        id
      ORDER BY
        updated_at
      DESC
      ', {:id => id}
    ])
  end

  # お気に入り記事一覧
  # -----------------------------------------
  def self.favorite_items(id)
    find_by_sql(['
      SELECT
        articles.*,
        users.id as "user_id",
        users.name,
        users.icon,
        media_files.media
      FROM
        users
      INNER JOIN
        articles
      ON
        users.id = articles.user_id
      INNER JOIN
        favorites
      ON
        articles.id = favorites.article_id
      LEFT OUTER JOIN
        media_files
      ON
        articles.id = media_files.article_id
      WHERE
        favorites.status = true
      AND
        favorites.user_id = :id
      GROUP BY
        id
      ORDER BY
        articles.created_at
      DESC
      ', {:id => id}
    ])
  end

  # 新着順
  # ------------------------------------------
  def self.select_new
    find_by_sql(['
      SELECT
        articles.*,
        users.id as "user_id",
        users.name,
        users.icon,
        media_files.media
      FROM
        articles
      INNER JOIN
        users
      ON
        articles.user_id = users.id
      LEFT OUTER JOIN
        media_files
      ON
        articles.id = media_files.article_id
      GROUP BY
        id
      ORDER BY
        articles.created_at
      DESC
    '])
  end

  # 人気順
  # -------------------------------------------
  def self.select_popular
    find_by_sql(['
      SELECT
        articles.*,
        users.id as "user_id",
        users.name,
        users.icon,
        media_files.media
      FROM
        articles
      INNER JOIN
        users
      ON
        articles.user_id = users.id
      LEFT OUTER JOIN
        media_files
      ON
        articles.id = media_files.article_id
      GROUP BY
        id
      ORDER BY
        articles.pv
      DESC
    '])
  end

  # 検索
  # -----------------------------------------
  def self.search_word(word)
    find_by_sql(['
      SELECT
        articles.*,
        users.id as "user_id",
        users.name,
        users.icon,
        media_files.media
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
      LEFT OUTER JOIN
        media_files
      ON
        articles.id = media_files.article_id
      WHERE
        (tags.name in (:word))
      OR
        articles.title LIKE "%":word"%"
      GROUP BY
        id
      ORDER BY
        created_at
      DESC
      ', {:word => word}
    ])
  end


end
