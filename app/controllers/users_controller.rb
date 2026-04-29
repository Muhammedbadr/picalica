class UsersController < ApplicationController
  # 1. أزلنا الـ :index من هنا لأن صفحة الكل لا تحتاج ID
  before_action :set_user, only: [:show, :edit, :update]
  def show
    # already set by set_user ✅
      @products = @user.products

  end

  def edit
    # nothing needed here ✅
    
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Data updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id]) 
  end

  def user_params
    params.require(:user).permit(
      :name, :lastname, :username, :email,
      :bio, :country, :date_of_birth,
      :phone_number, :avatar, :role_id
    )
  end
end