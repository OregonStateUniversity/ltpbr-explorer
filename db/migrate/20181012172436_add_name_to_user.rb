class AddNameToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, null: false, default: ''
    change_column_default :users, :name, nil
  end
end
