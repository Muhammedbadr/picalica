class UsersController < ApplicationController
  # 1. أزلنا الـ :index من هنا لأن صفحة الكل لا تحتاج ID
  before_action :set_user, only: [:show, :edit, :update]
  
  # def index
  #   @users = User.all
  # end

  def show
    # @user معرفة تلقائياً بفضل الـ before_action
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "تم تحديث البيانات!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    # بما أنك تستخدم Rails 8 (واضح من السكيما)، فإن expect ممتازة
    @user = User.find(params.expect(:id))
  end

  def user_params
    # تصحيح التكرار الذي كان موجوداً
    params.require(:user).permit(
      :name, :lastname, :username, :email, 
      :bio, :country, :date_of_birth, 
      :phone_number, :avatar, :role_id
    )
  end
end