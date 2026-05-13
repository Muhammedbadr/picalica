class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  has_many :products, through: :subcategories

  def self.ransackable_attributes(auth_object = nil)
    ["name", "id", "created_at", "updated_at"]
  end
end
