class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    # Get all products sold by current user
    @sold_products = current_user.products.joins(:order_items).distinct.order(created_at: :desc)

    # Calculate sales stats for each product
    @product_stats = {}
    @sold_products.each do |product|
      sold_count = product.order_items.count
      total_revenue = product.orders.joins(:payment).sum("payments.amount")

      @product_stats[product.id] = {
        sold_count: sold_count,
        total_revenue: total_revenue || 0
      }
    end

    @total_sold = @product_stats.values.sum { |stats| stats[:sold_count] }
    @total_revenue = @product_stats.values.sum { |stats| stats[:total_revenue] }
  end

  def show
    @product = current_user.products.find(params[:id])
    @sold_count = @product.order_items.count
    @total_revenue = @product.orders.joins(:payment).sum("payments.amount") || 0
    @sales = @product.order_items.includes(:order).order(created_at: :desc)
  end
end
