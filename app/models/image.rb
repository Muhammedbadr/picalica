class Image < ApplicationRecord
  belongs_to :product
  has_many_attached :images
  has_one_attached :cover_image
end
