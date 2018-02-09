class AddAuthorIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :author_id, :integer
  end
end
