json.extract! project, :id, :name, :description, :live_url, :github_url
json.url url_for(action: 'show', format: :json, only_path: false)
