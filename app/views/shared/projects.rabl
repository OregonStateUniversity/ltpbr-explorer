object :@projects
attributes :stream_name, :watershed, :url, :name, :primary_contact, :id, :implementation_date, :updated_at, :length, :number_of_structures
node(:latitude) { |project| project.lonlat.y }
node(:longitude) { |project| project.lonlat.x }
node(:cover_photo) { |project| project.photos[0].presence ? url_for(project.photos[0]) : "/missing_image.jpg"}
