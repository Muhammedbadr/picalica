class ProductFile < ApplicationRecord
  belongs_to :product
  has_one_attached :attachment

  # 1. Check if a file is actually there
  validates :attachment, attached: true, 
            content_type: ['application/pdf', 'application/zip', 'image/jpeg'],
            size: { less_than: 500.megabytes }
end