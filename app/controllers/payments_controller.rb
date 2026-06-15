class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  before_action :verify_product_license, only: :new

  def new    set_checkout_session
    redirect_to @checkout_session.url, allow_other_host: true
  rescue Stripe::InvalidRequestError, Stripe::AuthenticationError => e
    flash[:alert] = "Payment error: #{e.message}"
    redirect_to root_url
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, alert: "Product not found"
  end

  def verify_product_license
    unless @product.license&.price.present?
      redirect_to root_url, alert: "Product license not configured for payment"
    end
  end

  def set_checkout_session
    @checkout_session = Stripe::Checkout::Session.create({
      payment_method_types: [ "card" ],
      mode: "payment",
      line_items: [ {
        price_data: {
          currency: "usd",
          product_data: {
            name: "#{@product.title} — #{@product.license.title_name}"
          },
          unit_amount: (@product.license.price.to_f * 100).to_i
        },
        quantity: 1
      } ],
      metadata: {
        product_id: @product.id
      },
      success_url: cart_url,
      cancel_url: root_url
    })
  end
end
