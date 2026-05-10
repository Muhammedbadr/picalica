class CreateFeatureSections < ActiveRecord::Migration[8.1]
  def change
    create_table :feature_sections do |t|
      t.references :product, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
