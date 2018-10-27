class AddNotNullConstraintToProjectProjectWatershed < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :watershed, :string, null: false
  end
end
