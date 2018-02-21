object :@projects
attributes :stream_name
node(:latitude) { |project| project.lonlat.y }
node(:longitude) { |project| project.lonlat.x }