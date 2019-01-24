class Present < ApplicationRecord
  belongs_to :article
  mount_uploader :image, ImagesUploader
end
