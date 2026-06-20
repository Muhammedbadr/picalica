class ReviewsController < ApplicationController
  before_action :set_product
  def new
    @review = @product.reviews.build
  end
  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: "Review submitted successfully."
    else
      flash.now[:alert] = "Failed to submit review. Please check the form for errors."
      render :new
    end
  end
  private
  def set_product
    @product = Product.find(params[:product_id])
  end
  
  def review_params
  # Make sure all 4 fields are listed here
    params.require(:review).permit(:content, :work_quality, :communication, :ease_of_use, :documentation_quality)
  end
end
