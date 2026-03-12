class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.decimal :amount
      t.string :name
      t.string :info
      t.string :currency
      t.bigint :payment_method_id
      t.bigint :stripe_charge_id

      t.timestamps
    end
  end
end
