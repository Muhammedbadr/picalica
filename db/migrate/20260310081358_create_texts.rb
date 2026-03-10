class CreateTexts < ActiveRecord::Migration[8.1]
  def change
    create_table :texts do |t|
      t.references :product, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
