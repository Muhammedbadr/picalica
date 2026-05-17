class Image < ApplicationRecord
  belongs_to :product
  has_many_attached :pictures, dependent: :destroy

  has_one_attached :image, dependent: :destroy

  # All validators must be separated keys at the same level
  validates :image,
            content_type: ['image/png', 'image/jpeg'], # Removed 'image/jpg'
            dimension: { 
              width: { min: 1700 }, 
              message: "width must be 1700 px or larger" 
            }

  # validates :pictures, presence: true
end