class List < ApplicationRecord
  belongs_to :product
  has_many :list_tags, dependent: :destroy
  accepts_nested_attributes_for :list_tags, allow_destroy: true, reject_if: :all_blank
end
