class MediaFile < ApplicationRecord
  belongs_to :article
  mount_uploader :media, FileUploader
end
