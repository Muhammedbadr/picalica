class AddCustomFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role_id, :bigint
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :username, :string
    add_column :users, :country, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :phone_number, :string
    add_column :users, :bio, :text
  end
end
