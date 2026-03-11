class ProductFile < ApplicationRecord
  belongs_to :product
  has_one_attached :attachment
end
