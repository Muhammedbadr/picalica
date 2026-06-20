class OrdersController < ApplicationController
  def index
    @order_items = OrderItem
                    .joins(:order)
                    .where(orders: { user_id: current_user.id })
                    .where.not(orders: { status: "pending" })
                    .includes(product: [ :images, :user, :licenses, :product_files, subcategory: :category ], order: :payment)
                    .order("orders.created_at DESC")
  end

  def show
    @order = current_user.orders
                          .includes(order_items: { product: [ :images, :user ] })
                          .find(params[:id])
  end

  def new
    @order = Order.new
  end
end
