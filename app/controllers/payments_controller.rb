class PaymentsController < ApplicationController
  def create
    product = Product.find(params[:id])
    @session = Stripe::Checkout.create({
      payment_method_id: [ "card" ],
      line_itmes: [ {
        name: product.name,
        amount: product.price,
        currency: "usd",
        quantity: 1
      } ],
      mode: "payment",
      success_url: root_url,
      cancel_url: root_url
    })
    respond_to do |format|
      format.js
    end
  end
end
