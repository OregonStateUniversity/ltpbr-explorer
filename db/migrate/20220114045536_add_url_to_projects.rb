class AddUrlToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :url, :text
  end
end
