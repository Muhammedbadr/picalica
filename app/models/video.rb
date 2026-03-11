class Video < ApplicationRecord
  belongs_to :product
  has_one_attached :Video
end
