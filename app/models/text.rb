class Text < ApplicationRecord
  belongs_to :product
  has_one_attached :text
  validates :title, :description, presence: true
end
