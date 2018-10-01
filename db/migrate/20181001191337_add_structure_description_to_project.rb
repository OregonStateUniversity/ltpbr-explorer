class AddStructureDescriptionToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :structure_description, :text
  end
end
