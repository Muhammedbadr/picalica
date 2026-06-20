class UsersController < ApplicationController
  # 1. أزلنا الـ :index من هنا لأن صفحة الكل لا تحتاج ID
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

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

  def destroy
    if @user == current_user
      @user.destroy
      sign_out(@user) if user_signed_in?
      redirect_to root_path, notice: "Account successfully deleted."
    else
      redirect_to root_path, alert: "You can only delete your own account."
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
