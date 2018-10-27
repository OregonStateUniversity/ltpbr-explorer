class AddNotNullConstraintToStructureDescription < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :structure_description, :text, null: false
  end
end
