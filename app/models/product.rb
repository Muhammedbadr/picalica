class Product < ApplicationRecord
  # before_action :authenticate_user!

  # validates
  validates :title, presence: true
  validates :description, presence: true
  validates_associated :licenses
  validates_associated :texts, :feature_sections
  # 2. This ensures that IF there is a title, it starts with a capital letter
  validates :title, format: {
    with: /\A[A-Z]/,
    message: "must start with a capital letter"
  }, if: -> { title.present? } # Only check format if title is there

  # product belongs_to
  belongs_to :user
  belongs_to :subcategory 
  # has_one
  has_many :feature_sections, dependent: :destroy  # Optional: helper to get the parent category directly
  
  delegate :category, to: :subcategory, allow_nil: true 
  # has_many
  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags
  has_many :cart_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :texts, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :licenses, dependent: :destroy
  has_many :product_files, dependent: :destroy
  
  # accepts_nested_attributes
  accepts_nested_attributes_for :feature_sections, allow_destroy: true
  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :licenses, allow_destroy: true
  accepts_nested_attributes_for :product_files, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :texts, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :lists,  allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :videos, allow_destroy: true


  def thumbnail
    images.image.variant(resize: [ 300, 300 ]).processed
  end

  
  # This allows filtering like: Product.tagged_with("online store")
end
