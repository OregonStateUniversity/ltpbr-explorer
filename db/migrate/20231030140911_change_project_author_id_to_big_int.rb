class ChangeProjectAuthorIdToBigInt < ActiveRecord::Migration[7.1]
  def up
    change_column :projects, :author_id, :bigint
    add_index :projects, :author_id
  end

  def down
    remove_index :projects, :author_id
    change_column :projects, :author_id, :integer
  end
end
