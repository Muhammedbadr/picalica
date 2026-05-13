class HomeController < ApplicationController
before_action :load_categories

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)

  end
  # application_controller.rb

  def load_categories
    @nav_categories = Category.includes(:subcategories).all
  end
end
