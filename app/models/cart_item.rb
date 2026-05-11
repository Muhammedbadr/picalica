class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :item_title, :description, presence: true
end
