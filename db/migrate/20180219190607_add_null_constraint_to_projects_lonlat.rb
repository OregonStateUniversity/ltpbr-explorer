class AddNullConstraintToProjectsLonlat < ActiveRecord::Migration[5.1]
  def change
    change_column_null :projects, :lonlat, false
  end
end
