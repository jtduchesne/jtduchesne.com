json.extract! message, :id, :from, :subject, :body, :created_at
json.url url_for(action: 'show', format: :json, only_path: false)
