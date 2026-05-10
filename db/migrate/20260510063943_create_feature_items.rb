class CreateFeatureItems < ActiveRecord::Migration[8.1]
  def change
    create_table :feature_items do |t|
      t.references :feature_section, null: false, foreign_key: true
      t.string :item_title
      t.text :description

      t.timestamps
    end
  end
end
