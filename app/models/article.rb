class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :media_files, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :presents, dependent: :destroy
end
