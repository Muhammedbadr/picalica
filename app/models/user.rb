class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :purchased_products, through: :orders, source: :products

  has_many :user_roles
  belongs_to :role, optional: true
  has_many :products 
  has_many :reviews, dependent: :destroy

  after_create do 
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
  
end
