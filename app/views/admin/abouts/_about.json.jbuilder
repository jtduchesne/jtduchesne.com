json.extract! about, :id, :created_at, :updated_at
json.url url_for(action: 'show', format: :json, only_path: false)
