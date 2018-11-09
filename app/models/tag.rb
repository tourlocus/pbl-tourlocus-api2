class Tag < ApplicationRecord
  has_many :article_tags, dependent: :destroy
end
