class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.string :heading
      t.string :title
      t.text :description
      t.string :story
      t.string :position
      t.boolean :exclusive_product, default: false
      t.string :issue_number
      t.integer :subcategory_id

      t.timestamps
    end
  end
end