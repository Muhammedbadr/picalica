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
  belongs_to :subcategory 
  # Optional: helper to get the parent category directly
  delegate :category, to: :subcategory, allow_nil: true 
  has_many :product_tags, dependent: :destroy
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
    images.image.variant(resize: [ 300, 300 ]).processed
  end

  # This allows filtering like: Product.tagged_with("online store")
  def self.tagged_with(name)
    Tag.find_by!(name: name).products
  end

  # Helper to show tags as a string (e.g., "online store, personal website")
  def tag_list
    tags.map(&:name).join(", ")
  end

  # This logic creates tags automatically if you type a new one
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
