json.extract! state, :id, :name, :iso_code, :created_at, :updated_at, :projects_count
json.url state_url(state, format: :json)
