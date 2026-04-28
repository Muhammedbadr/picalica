class Product < ApplicationRecord
  # before_action :authenticate_user!
  # validates :title, presence: true
  validates :description, presence: true
  validates_associated :licenses
  validates :title, presence: true 
    
    # 2. This ensures that IF there is a title, it starts with a capital letter
  validates :title, format: { 
    with: /\A[A-Z]/, 
    message: "must start with a capital letter" 
  }, if: -> { title.present? } # Only check format if title is there


  belongs_to :user
  belongs_to :subcategory , optional: true 
  
  has_many :product_tags , dependent: :destroy
  has_many :tags, through: :product_tags
  
  has_many :cart_items, dependent: :destroy
  
  has_many :reviews, dependent: :destroy

  
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  
  has_many :videos, dependent: :destroy
  has_many :texts, dependent: :destroy   
  has_many :lists, dependent: :destroy
  has_many :licenses, dependent: :destroy
  has_many :product_files, dependent: :destroy
  # accepts_nested_attributes_form :images, allow_destroy: true
  
  accepts_nested_attributes_for :licenses, allow_destroy: true
  accepts_nested_attributes_for :product_files, allow_destroy: true, reject_if: :all_blank

  accepts_nested_attributes_for :texts,  allow_destroy: true
  accepts_nested_attributes_for :lists,  allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true


  def thumbnail
    return images.image.variant(resize: [300, 300]).processed
  end
 
 
end
