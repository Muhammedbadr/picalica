class ProductsController < ApplicationController
  before_action :authenticate_user!
  # before_action :require_seller, only: [:new, :create]
  # before_action :set_product, only: [:show, :edit, :update, :destroy , :update_step_two]
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
      # خطأ: لا يمكنك وضع 2 redirect_to خلف بعضهما
      # سنبقي فقط الانتقال للخطوة الثانية
      redirect_to step_two_product_path(@product), notice: "Basic data has been saved, please complete the images and files"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def step_two
    # تعرض صفحة الصور والملفات (التي أنشأناها يدوياً)
    # @product.images.build if @product.images.empty?
    @product = Product.find(params[:id])
  end

  def update_step_two
    @product = Product.find(params[:id])
    if @product.update(product_step_two_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :step_two , status: :unprocessable_entity
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
        :preview_url,
        :exclusive_product,
        :issue_number,
        :subcategory_id,
        licenses_attributes: [:id, :price, :title_name, :_destroy],
                # images_attributes: [:id, :title , :_destroy  , images: [] ],
        product_files_attributes: [:id, :attachment, :_destroy]   
    )
    end
    
    def product_step_two_params
      params.require(:product).permit( :picture , images: [] 

      )
    end

    def authorize_owner!
      unless @product.user == current_user
        redirect_to products_path, alert: "Not authorized"
      end
    end
end
