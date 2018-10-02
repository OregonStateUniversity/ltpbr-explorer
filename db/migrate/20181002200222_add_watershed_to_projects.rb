class AddWatershedToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :watershed, :string
  end
end
