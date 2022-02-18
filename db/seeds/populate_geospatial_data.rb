puts "Deleting all previous geographical data..."

connection = ActiveRecord::Base.connection()

State.delete_all
Country.delete_all

connection.execute "ALTER SEQUENCE states_id_seq RESTART WITH 1"
connection.execute "ALTER SEQUENCE countries_id_seq RESTART WITH 1"

puts

if Country.all.count == 0
  puts "Importing country data..."

  from_country_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 4326 #{Rails.root.join("db", "shapefiles", "gadm36_USA_0.shp")} countries_ref`
  connection.execute "drop table if exists countries_ref"
  connection.execute from_country_shp_sql
  connection.execute <<-SQL
      insert into countries(name, iso_code, geom, total_length, total_number_of_structures, created_at, updated_at)
        select NAME_0, GID_0, geom, 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP from countries_ref
  SQL
  connection.execute "drop table countries_ref"
end

puts "Countries added:"
Country.all.each do |country|
  puts "#{country.id}, #{country.name}, #{country.iso_code}"
end

usa_id = Country.all.first.id
puts "USA country ID = #{usa_id}"

puts

if State.all.count == 0
  puts "Importing state data..."

  from_province_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 4326 #{Rails.root.join("db", "shapefiles", "gadm36_USA_1.shp")} states_ref`
  connection.execute "drop table if exists states_ref"
  connection.execute from_province_shp_sql
  connection.execute <<-SQL
      insert into states(country_id, name, hasc_code, state_type, geom, total_length, total_number_of_structures, created_at, updated_at)
        select #{usa_id}, NAME_1, HASC_1, ENGTYPE_1, geom, 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP from states_ref
  SQL
  connection.execute "drop table states_ref"

  puts
end

puts "States added:"
State.all.each do |state|
  puts "#{state.id}, #{state.name}, #{state.hasc_code}, #{state.state_type}"
end
