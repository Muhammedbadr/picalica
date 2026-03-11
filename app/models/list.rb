class List < ApplicationRecord
  belongs_to :product
  has_many :list_tags, dependent: :destroy
end
