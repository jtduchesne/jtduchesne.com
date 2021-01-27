json.extract! about, :id, :created_at, :updated_at
json.fr about.fr.body
json.en about.en.body
json.url url_for(action: 'show', format: :json, only_path: false)
