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

  def total_items_count
    cart_items.count
  end

  def total
    cart_items.to_a.sum { |item| item.license&.price.to_f || item.product.licenses.first&.price.to_f }
  end

  def total_price
    total
  end

  def ready_for_checkout?
    cart_items.all? { |item| item.license&.price.present? || item.product.licenses.first&.price.present? }
  end

  def misconfigured_products
    cart_items
      .select { |item| item.license&.price.blank? && item.product.licenses.first&.price.blank? }
      .map { |item| item.product.title }
  end
end
