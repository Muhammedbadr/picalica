  class ProductsController < ApplicationController
    # before_action :authenticate_user!
    # before_action :require_seller, only: [:new, :create]
    before_action :set_product, only: [ :show, :edit, :update, :destroy, :step_two, :update_step_two ]
    before_action :authorize_owner!, only: [ :edit, :update, :destroy ]
    def index
      @products = Product.all
      @user = current_user
    end

    # GET /products/1 or /products/1.json
    def edit
      @product = Product.find(params[:id])
      @step = params[:step] || "1"
      @product.licenses.build       if @product.licenses.empty?
      @product.product_files.build  if @product.product_files.empty?
      @product.images.build         if @product.images.empty?
    end

    # GET /products/new
    def new
      @product = Product.new
      # @product.images.build
      @product.licenses.build
      @product.product_files.build
        @categories = Category.includes(:subcategories).all

    end

    # POST /products or /products.json
    def create
      @product = current_user.products.build(product_params)
        @categories = Category.includes(:subcategories).all  # ← add this

      if @product.save

        redirect_to step_two_product_path(@product), notice: "Basic data has been saved, please complete the images and files"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def step_two
      @product = Product.find(params[:id])
    end

    def update_step_two
      @product = Product.find(params[:id])
      if @product.update(product_step_two_params)
        redirect_to @product, notice: "Product was successfully updated."
      else
        render :step_two, status: :unprocessable_entity
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
          :category_id,
          :subcategory_id,
          licenses_attributes: [ :id, :price, :title_name, :_destroy ],
          # images_attributes: [:id, :title , :_destroy  , images: [] ],
          product_files_attributes: [ :id, :attachment, :_destroy ],
          tag_ids: [] ,  # This allows passing an array of tag IDs for the product
      )
      end

      def product_step_two_params
        params.require(:product).permit(
          images_attributes: [
            :id,
            :title,
            :_destroy,
            :image,        # has_one_attached :image  (single photo per block)
            pictures: []   # has_many_attached :pictures (multiple photos per block)
          ]
        )
      end

      def authorize_owner!
        unless @product.user == current_user
          redirect_to products_path, alert: "Not authorized"
        end
      end
  end
