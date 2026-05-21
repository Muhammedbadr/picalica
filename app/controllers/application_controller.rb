class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :set_nav_categories
  before_action :set_current_cart, if: :user_signed_in?
  # before_action :set_render_cart
  # before_action :initialize_cart
  stale_when_importmap_changes

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :role_id, :name, :lastname, :username, :country, :date_of_birth, :phone_number, :bio ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :role_id, :name, :lastname, :username, :country, :date_of_birth, :phone_number, :bio ])
  end

  private
  def set_current_cart
    @cart = current_user.cart || current_user.create_cart
  end

  # def set_render_cart
  #   @render_cart = false
  # end
  # def initialize_cart
  #   @cart ||= Cart.find_by(id: session[:cart_id])

  #   if @cart.nil?
  #     @cart = Cart.create
  #     session[:cart_id] = @cart.id
  #   end
  # end
  def set_nav_categories
    @nav_categories = Category.includes(:subcategories, :products).all
  end
end
