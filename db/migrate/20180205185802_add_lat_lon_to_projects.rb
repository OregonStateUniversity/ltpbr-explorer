class AddLatLonToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :lonlat, :st_point, geographic: true
  end
end
