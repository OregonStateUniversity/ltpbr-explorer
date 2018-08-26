class RemoveMaintenanceFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :maintenance
  end
end
