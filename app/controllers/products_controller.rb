class ProductsController < ApplicationController
  before_action :authenticate_user!
  # before_action :require_seller, only: [:new, :create]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]
  
  def index
    @products = Product.all
    
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
   

    # @product.images.build
    @product.licenses.build
    @product.product_files.build
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.build(product_params)
    

    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      puts @product.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
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

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Product was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end
    
    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(
        :heading,
        :title,
        :description,
        :story,
        :position,
        :exclusive_product,
        :issue_number,
        :subcategory_id,
        licenses_attributes: [:id, :price, :title_name, :_destroy],
        # images_attributes: [:id, :_destroy]
        product_files_attributes: [:id, :attachment, :_destroy]   
    )
    end
    

    def authorize_owner!
      unless @product.user == current_user
        redirect_to products_path, alert: "Not authorized"
      end
    end
end
