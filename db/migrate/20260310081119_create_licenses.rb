class CreateLicenses < ActiveRecord::Migration[8.1]
  def change
    create_table :licenses do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :price
      t.string :title_name

      t.timestamps
    end
  end
end
