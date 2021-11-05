object :@projects
attributes :stream_name, :watershed, :name, :primary_contact, :id
node(:latitude) { |project| project.lonlat.y }
node(:longitude) { |project| project.lonlat.x }
node(:photo) { |project| project.photo }