class CartItemsController < ApplicationController
  def create
    @cart = current_user.cart || current_user.create_cart
    product = Product.find(params[:id]) # Form passes :id

    # If the product is already in the cart, skip adding and warn the user
    if @cart.products.include?(product)
      redirect_to cart_path, alert: "This item is already in your cart!"
      return
    end

    @cart_item = @cart.add_product(product.id)

    if @cart_item.save
      redirect_to cart_path, notice: 'Product added to cart.'
    else
      redirect_back fallback_location: root_path, alert: 'Unable to add item.'
    end
  end
  

  def destroy
    # 1. Find the cart item belonging strictly to the logged-in user's cart
    @cart_item = current_user.cart.cart_items.find(params[:id])
    
    # 2. Destroy the join record
    @cart_item.destroy

    # 3. Redirect back to the cart view
    redirect_to cart_path, notice: "Item removed from cart."
  end
end
