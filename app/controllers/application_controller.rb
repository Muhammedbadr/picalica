class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :set_nav_categories

  stale_when_importmap_changes

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role_id, :name, :lastname, :username, :country, :date_of_birth, :phone_number, :bio])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role_id, :name, :lastname, :username, :country, :date_of_birth, :phone_number, :bio])
  end

  private

  def set_nav_categories
    @nav_categories = Category.includes(:subcategories, :products).all
  end
end