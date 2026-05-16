class HomeController < ApplicationController
before_action :load_categories

  def index
    @user = current_user
    
    # 1. Always load categories for the view sidebar/grid to prevent nil errors
    @categories = Category.includes(:products) 

    if params[:subcategory].present?
      # Note: Ensure @products is initialized before calling .joins on it
      @products = Product.joins(:subcategory).where(subcategories: { name: params[:subcategory] })
    elsif params[:category].present?
      @category = Category.find_by(name: params[:category])
      @products = @category ? @category.products : Product.none
    else
      @q = Product.ransack(params[:q])
      @products = @q.result(distinct: true)
    end 
  end

  # application_controller.rb

  def load_categories
    @nav_categories = Category.includes(:subcategories).all
  end
end
