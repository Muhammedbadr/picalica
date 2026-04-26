class Image < ApplicationRecord
  belongs_to :product
  has_many_attached :pictures, dependent: :destroy
  has_one_attached :image, dependent: :destroy
end