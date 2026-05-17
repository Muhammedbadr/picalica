class HomeController < ApplicationController
  def index
    @user = current_user
    @categories = Category.includes(:products)

    if params[:subcategory].present?
    @products = Product.joins(:subcategory)
                       .where(subcategories: { name: params[:subcategory] })
    elsif params[:category].present?
      @category = Category.find_by(name: params[:category])
      @products = @category ? @category.products : Product.none
    else
      @q = Product.ransack(params[:q])
      @products = @q.result(distinct: true)
    end
  end
  
end
