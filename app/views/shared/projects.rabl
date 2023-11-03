object :@projects
attributes :stream_name, :watershed, :url, :name, :primary_contact, :id, :implementation_date, :updated_at, :length, :number_of_structures, :xxx_cover_photo
node(:latitude) { |project| project.lonlat.y }
node(:longitude) { |project| project.lonlat.x }
