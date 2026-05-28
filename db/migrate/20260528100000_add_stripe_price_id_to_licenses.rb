class AddStripePriceIdToLicenses < ActiveRecord::Migration[8.1]
  def change
    add_column :licenses, :stripe_price_id, :string
  end
end
