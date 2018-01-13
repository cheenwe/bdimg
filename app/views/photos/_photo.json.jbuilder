json.extract! photo, :id, :search_id, :url, :created_at, :updated_at
json.url photo_url(photo, format: :json)
