class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :products , dependent: :restrict_with_error

  def self.ransackable_attributes(auth_object = nil)
    ["name", "category_id", "created_at", "updated_at", "id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
