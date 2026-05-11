class FeatureItem < ApplicationRecord
  belongs_to :feature_section
  validates :item_title, :description, presence: true
end
