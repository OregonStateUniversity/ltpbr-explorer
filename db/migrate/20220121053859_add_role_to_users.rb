class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      CREATE TYPE user_role AS ENUM ('public', 'admin');
    SQL
    add_column :users, :role, :user_role, default: 'public'
  end

  def down
    remove_column :users, :role
    execute <<-SQL
      DROP TYPE user_role;
    SQL
  end
end
