object :@projects
attributes :stream_name, :watershed, :url, :name, :primary_contact, :id, :implementation_date, :updated_at, :length, :number_of_structures
node(:latitude) { |project| project.lonlat.y }
node(:longitude) { |project| project.lonlat.x }
node(:cover_photo) { 
  |project|
    if !project.cover_photo_id.nil? && project.photos.where(id: project.cover_photo_id).presence
      url_for(project.photos.where(id: project.cover_photo_id)[0])
    elsif project.photos[0].presence
      url_for(project.photos[0])
    else
      "/missing_image_camera.png"
    end
}
