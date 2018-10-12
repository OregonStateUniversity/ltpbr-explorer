class ChangeProjectProjectNameToName < ActiveRecord::Migration[5.1]
  def change
    rename_column :projects, :project_name, :name
  end
end
