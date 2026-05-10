class FeatureSection < ApplicationRecord
  belongs_to :product
  has_many :feature_items, dependent: :destroy
  accepts_nested_attributes_for :feature_items, allow_destroy: true
end
