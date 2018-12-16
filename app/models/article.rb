class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :media_files, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :presents, dependent: :destroy

  def self.left_joins_media(mlist)
    Article.joins(sanitize_sql_array(['LEFT OUTER JOIN media_files ON media_files.article_id = articles.id AND media_files.id IN (?)', mlist]))
  end
end
