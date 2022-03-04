puts "Deleting all previous geographical data..."

connection = ActiveRecord::Base.connection()

Project.find_each(:batch_size => 1000) do |project|
  project.update_column(:state_id, nil)
end

State.delete_all
Country.delete_all

connection.execute "ALTER SEQUENCE states_id_seq RESTART WITH 1"
connection.execute "ALTER SEQUENCE countries_id_seq RESTART WITH 1"

puts

if Country.all.count == 0
  puts "Importing country data..."

  from_country_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 4326 #{Rails.root.join("db", "shapefiles", "ne_110m_admin_0_countries.shp")} countries_ref`
  connection.execute "drop table if exists countries_ref"
  connection.execute from_country_shp_sql
  connection.execute <<-SQL
      insert into countries(name, iso_code, geom, created_at, updated_at)
        select NAME_EN, ISO_A3, geom, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP from countries_ref
  SQL
  connection.execute "drop table countries_ref"
end

puts "Countries added:"
Country.all.each do |country|
  puts "#{country.id}, #{country.name}, #{country.iso_code}"
end

usa_id = Country.find_by(iso_code: "USA").id

if State.all.count == 0
  puts "Importing state data for USA..."

  from_province_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 4326 #{Rails.root.join("db", "shapefiles", "ne_110m_admin_1_states_provinces.shp")} states_ref`
  connection.execute "drop table if exists states_ref"
  connection.execute from_province_shp_sql
  connection.execute <<-SQL
      insert into states(country_id, name, iso_code, state_type, geom, created_at, updated_at)
        select #{usa_id}, NAME_EN, iso_3166_2, type, geom, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP from states_ref
  SQL
  connection.execute "drop table states_ref"

  puts
end

puts "States added:"
State.all.each do |state|
  puts "#{state.id}, #{state.name}, #{state.iso_code}, #{state.state_type}"
end

puts "Assigning states to projects..."
Project.find_each(:batch_size => 1000) do |project|
  project.update_column(:state_id, project.calculate_state)
end
