class AddSubcategoryToProducts < ActiveRecord::Migration[8.1]
  def change
    add_reference :products, :subcategory, null: false, foreign_key: true
  end
end
