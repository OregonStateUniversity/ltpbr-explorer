class AddProjectNameToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :project_name, :string
  end
end
