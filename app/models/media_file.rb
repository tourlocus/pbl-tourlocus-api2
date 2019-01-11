class MediaFile < ApplicationRecord
  belongs_to :article
  mount_uploader :media, FileUploader

  # 1つ目のmediaずつ抽出 -> media_filesのidをリスト化
  def self.select_media_list(mlist)
    select("min(id) as id")
      .where(article_id: mlist.pluck("id").uniq)
      .group(:article_id).map(&:id)
  end
end
