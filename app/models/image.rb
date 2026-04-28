class Image < ApplicationRecord
  belongs_to :product
  has_many_attached :pictures, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  # validate :file_type
  #  private 

  # def file_type
  #   if !images.attached?
  #     errors.add(:images, "must be attached")
  #     return
  #   end

  #   images.each do |image|
  #     unless image.content_type.in?(%w[image/jpeg image/png image/gif])
  #       errors.add(:images, "must be a JPEG, PNG, or GIF")
  #     end
  #   end
end