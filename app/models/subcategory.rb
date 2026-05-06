class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :products , dependent: :restrict_with_error
end
