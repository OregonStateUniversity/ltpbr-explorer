class RemoveAdminRoleFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :admin_role
  end
end
