class RemoveRoleIdFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :role_id, :bigint
  end
end