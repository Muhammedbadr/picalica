class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def show
    # @cart already set by before_action
  end

  def pay
    create_checkout_session
    redirect_to @checkout_session.url, allow_other_host: true
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

      unless license&.price.present?
        raise Stripe::InvalidRequestError.new("Product '#{product.title}' is not configured for payment", "price")
      end

      {
        price_data: {
          currency: "usd",
          product_data: {
            name: "#{product.title} — #{license.title_name}"
          },
          unit_amount: (license.price.to_f * 100).to_i
        },
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
      success_url: cart_url,
      cancel_url: cart_url
    })
  end
end
