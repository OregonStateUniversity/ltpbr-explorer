class AddNotNullConstraintToProjectLength < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :length, :integer, null: false
  end
end
