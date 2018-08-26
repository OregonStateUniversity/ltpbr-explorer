class AddNumberOfStructuresToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :number_of_structures, :integer
  end
end
