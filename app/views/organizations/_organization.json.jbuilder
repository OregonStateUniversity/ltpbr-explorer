json.extract! organization, :id, :name, :description, :contact, :website, :created_at, :updated_at, :affiliations_count
json.url organization_url(organization, format: :json)
