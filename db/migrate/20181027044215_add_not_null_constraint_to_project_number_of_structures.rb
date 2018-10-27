class AddNotNullConstraintToProjectNumberOfStructures < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :number_of_structures, :integer, null: false
  end
end
