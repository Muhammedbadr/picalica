class AddPreviewUrlToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :preview_url, :string
  end
end
