class User < ApplicationRecord
  # before_action :authenticate_user!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :purchased_products, through: :orders, source: :products
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :username, presence: true, uniqueness: true
  
  has_many :user_roles
  belongs_to :role, optional: true
  has_many :products 
  has_one :cart, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :avatar
  
  # has_one :images

  after_create do 
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
  def owns_product?(product)
    products.exists?(id: product.id)
  end
  
end
