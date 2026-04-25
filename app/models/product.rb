class Product < ApplicationRecord
  # before_action :authenticate_user!

  belongs_to :user
  belongs_to :subcategory , optional: true 
  
  has_many :product_tags , dependent: :destroy
  has_many :tags, through: :product_tags
  
  has_many :cart_items, dependent: :destroy
  
  has_many :reviews, dependent: :destroy

  has_many_attached :images, dependent: :destroy
  has_one_attached :picture, dependent: :destroy

  has_many :videos, dependent: :destroy
  has_many :texts, dependent: :destroy   
  has_many :lists, dependent: :destroy
  has_many :licenses, dependent: :destroy
  has_many :product_files, dependent: :destroy
  
  accepts_nested_attributes_for :licenses, allow_destroy: true
  accepts_nested_attributes_for :product_files, allow_destroy: true, reject_if: :all_blank
# app/models/product.rb
  # validates :product_files, length: { 
  #     minimum: 1, 
  #     maximum: 5, 
  #     message: "must have between 1 and 5 files" 
  #   }
  # validates :preview_url, 
  #   format: { with: URI::DEFAULT_PARSER.make_regexp,
  #   message: "must be a valid URL" }, allow_blank: true
  # accepts_nested_attributes_for :images, allow_destroy: true
end
