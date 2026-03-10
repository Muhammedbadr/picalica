class CreateVideos < ActiveRecord::Migration[8.1]
  def change
    create_table :videos do |t|
      t.references :product, null: false, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
