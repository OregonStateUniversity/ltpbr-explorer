class ChangeProjectAreaToLength < ActiveRecord::Migration[5.1]
  def change
    rename_column :projects, :area, :length
  end
end
