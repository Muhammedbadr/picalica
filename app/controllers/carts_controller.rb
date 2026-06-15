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

  def charge
    if params[:session_id].blank?
      redirect_to cart_path, alert: "Payment session was not returned by Stripe."
      return
    end

    session = Stripe::Checkout::Session.retrieve(params[:session_id])

    if session.metadata.user_id.to_s != current_user.id.to_s || session.metadata.cart_id.to_s != @cart.id.to_s
      redirect_to cart_path, alert: "Payment session does not belong to this cart."
      return
    end

    unless session.payment_status == "paid"
      redirect_to cart_path, alert: "Payment was not completed."
      return
    end

    ActiveRecord::Base.transaction do
      @order = current_user.orders.create!(status: "paid")

      @cart.cart_items.each do |item|
        @order.order_items.create!(product: item.product)
      end

      stripe_charge_id = if session.payment_intent.present?
        payment_intent_id = session.payment_intent
        charge = Stripe::Charge.list(payment_intent: payment_intent_id, limit: 1).data.first
        charge&.id
      end

      @order.create_payment!(amount: @cart.total, currency: "usd", stripe_charge_id: stripe_charge_id)
      @cart.cart_items.destroy_all
    end

    redirect_to order_path(@order), notice: "Order placed successfully!"
  rescue Stripe::StripeError => e
    redirect_to cart_path, alert: "Payment validation failed: #{e.message}"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to cart_path, alert: "Unable to finalize order: #{e.record.errors.full_messages.to_sentence}"
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

      raw_success_url = "#{charge_cart_url}?session_id={CHECKOUT_SESSION_ID}"

      @checkout_session = Stripe::Checkout::Session.create({
      payment_method_types: [ "card" ],
      mode: "payment",
      line_items: line_items,
      metadata: {
        cart_id: @cart.id,
        user_id: current_user.id
      },
      success_url: raw_success_url,
      cancel_url: cart_url
    })
  end
end
