class AddLicenseToCartItems < ActiveRecord::Migration[8.1]
  def change
    add_reference :cart_items, :license, foreign_key: true, index: true
  end
end
