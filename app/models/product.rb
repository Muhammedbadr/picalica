class Product < ApplicationRecord
  belongs_to :user
  belongs_to :subcategory , optional: true 
  
  has_many :product_tags , dependent: :destroy
  has_many :tags, through: :product_tags
  
  has_many :reviews, dependent: :destroy

  has_many :images, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :texts, dependent: :destroy   
  has_many :lists, dependent: :destroy
  has_many :licenses, dependent: :destroy
  has_many :product_files, dependent: :destroy
end
