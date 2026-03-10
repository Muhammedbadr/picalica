class CreateListTags < ActiveRecord::Migration[8.1]
  def change
    create_table :list_tags do |t|
      t.references :list, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
