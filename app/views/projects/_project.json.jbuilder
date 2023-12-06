json.extract! project, :id, :name, :stream_name, :watershed, :implementation_date, :narrative, :length, :primary_contact, :lonlat, :number_of_structures, :structure_description, :affiliations_count, :project_photos_count, :author_id, :state_id, :created_at, :updated_at
json.home_page_url project.url
json.url project_url(project, format: :json)
