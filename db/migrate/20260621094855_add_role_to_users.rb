class AddRoleToUsers < ActiveRecord::Migration[8.1]
  def change
    # default: 0 sets all existing users to 'user' automatically
    add_column :users, :role, :integer, default: 0, null: false
  end
end