class Product < ApplicationRecord
  belongs_to :user
  belongs_to :subcategory , optional: true # Allows saving even if subcategory is empty
end
