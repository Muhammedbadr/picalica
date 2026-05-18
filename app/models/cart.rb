class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  has_many :products, through: :cart_items

  def add_product(product_id)
    # Check if this product is already in the cart items collection
    current_item = cart_items.find_by(product_id: product_id)
    
    # If it's not in the cart, create a new record. If it is, return it as-is.
    current_item ||= cart_items.build(product_id: product_id)
  end

  def remove_product(product_id)
    item = cart_items.find_by(product_id: product_id)
    item&.destroy # The ampersand prevents an error if the item was already deleted
  end
 
  def total
    # Sum up the price of the first license for every product in the cart
    cart_items.to_a.sum { |item| item.product.licenses.first&.price.to_f }
  end
end
