class Image < ApplicationRecord
  belongs_to :product
  has_many_attached :pictures, dependent: :destroy

  has_one_attached :image, dependent: :destroy
    validates :image,
    dimension: {
      width: { min: 1700 },
      message: "The image width must be 1700 px or larger"
    }
end