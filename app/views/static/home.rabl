object :@projects
attributes :stream_name, :watershed, :project_name, :primary_contact, :id
node(:latitude) { |project| project.lonlat.y }
node(:longitude) { |project| project.lonlat.x }
