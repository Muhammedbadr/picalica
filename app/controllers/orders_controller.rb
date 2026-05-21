class OrdersController < ApplicationController
  def index
    # @orders = Order.all
    @orders = current_user.orders.where.not(status: 'pending').order(created_at: :desc)

  end

  def show
    # @order = Order.find(params[:id])
    @order = current_user.orders.find_or_create_by(status: 'pending')

  end

  def new
    @order = Order.new
  end
end
