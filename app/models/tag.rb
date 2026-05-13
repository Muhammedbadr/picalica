class Tag < ApplicationRecord
    has_many :product_tags, dependent: :destroy
    has_many :products, through: :product_tags
    def self.ransackable_attributes(auth_object = nil)
        ["name", "id"]
    end
end
