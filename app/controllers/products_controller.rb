class ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy, :step_two, :update_step_two ]
  before_action :authorize_owner!, only: [ :edit, :update, :destroy ]
  before_action :set_categories, only: [ :new, :create, :edit, :update ]  # ← add this

  def index
    @products = Product.all
    @user = current_user
  end

  def show
  end

  def edit
    @product = Product.find(params[:id])
    @step = params[:step] || "1"
    @product.licenses.build      if @product.licenses.empty?
    @product.product_files.build if @product.product_files.empty?
    @product.images.build        if @product.images.empty?
    # REMOVED the wrong lines
  end

  def new
    @product = Product.new
    @product.licenses.build
    @product.product_files.build
    @product.texts.build if @product.texts.empty?
    @product.videos.build if @product.videos.empty?
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      redirect_to step_two_product_path(@product), notice: "Basic data has been saved!"
    else
      puts @product.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def step_two
    @product = Product.find(params[:id])
    @product.texts.build if @product.texts.empty?
    @product.videos.build if @product.videos.empty?
  end

  def update_step_two
    @product = Product.find(params[:id])
    if @product.update(product_step_two_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :step_two, status: :unprocessable_entity
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy!
    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])  # ← fixed params.expect → params[]
  end

  def set_categories
    @categories = Category.includes(:subcategories).all  # ← one place, always runs
  end

  def product_params
    params.require(:product).permit(
      :heading, :title, :description, :story, :position,
      :preview_url, :exclusive_product, :issue_number,
      :category_id, :subcategory_id,
      licenses_attributes: [ :id, :price, :title_name, :_destroy ],
      product_files_attributes: [ :id, :attachment, :_destroy ],
      tag_ids: []
    )
  end

  def product_step_two_params
    params.require(:product).permit(
      images_attributes: [ :id, :title, :_destroy, :image, pictures: [] ],
      texts_attributes: [ :id, :title, :description, :_destroy ],
      videos_attributes: [ :id, :title, :link, :_destroy]
    )
  end

  def authorize_owner!
    unless @product.user == current_user
      redirect_to products_path, alert: "Not authorized"
    end
  end
end
