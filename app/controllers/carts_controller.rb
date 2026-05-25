class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    # @cart already set by before_action
  end

  def pay
    create_checkout_session
  rescue Stripe::InvalidRequestError, Stripe::AuthenticationError => e
    flash[:alert] = "Payment error: #{e.message}"
    redirect_to cart_path
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def create_checkout_session
    # Build line items from cart items
    line_items = @cart.cart_items.map do |item|
      product = item.product
      license = item.respond_to?(:license) ? item.license : product.licenses.first

      unless license&.stripe_price_id.present?
        raise Stripe::InvalidRequestError.new("Product '#{product.title}' is not configured for payment")
      end

      {
        price: license.stripe_price_id,
        quantity: 1
      }
    end

    @checkout_session = Stripe::Checkout::Session.create({
      payment_method_types: [ "card" ],
      mode: "payment",
      line_items: line_items,
      metadata: {
        cart_id: @cart.id,
        user_id: current_user.id
      },
      success_url: pay_cart_url,
      cancel_url: cart_path
    })
  end
end
