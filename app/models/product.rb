class Product < ApplicationRecord
  belongs_to :user
  belongs_to :subcategory , optional: true 

  has_many :images, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :licenses, dependent: :destroy
end
