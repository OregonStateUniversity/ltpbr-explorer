# Add a NOT NULL constraint to projects.name. Use an initial default value
# of an empty string for existing records in the database. Then remove the
# default value property of the column.
class AddNotNullConstraintToProjectName < ActiveRecord::Migration[5.1]
  def change
    change_column :projects, :name, :string, null: false, default: ''
    change_column_default :projects, :name, nil
  end
end
