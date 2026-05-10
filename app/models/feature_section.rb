class FeatureSection < ApplicationRecord
  belongs_to :product
  has_many :feature_items, dependent: :destroy
end
