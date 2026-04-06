class PaymentsController < ApplicationController
  def create
    # Use params[:product_id] if your route is nested
    product = Product.find(params[:product_id])

    # For now, let's use a temporary price since we are still setting up Licenses
    # Stripe needs an Integer in CENTS ($20.00 = 2000)
    test_price = 2000 

    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          unit_amount: test_price, 
          product_data: {
            name: product.title, # Matches your 'title' column
          },
        },
        quantity: 1,
      }],
      mode: "payment",
      success_url: root_url,
      cancel_url: root_url,
    })

    respond_to do |format|
      format.js # This looks for create.js.erb
    end
  end
end